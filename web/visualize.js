chart = {
    const root = d3.hierarchy(data);
const links = root.links();
const nodes = root.descendants();

const simulation = d3.forceSimulation(nodes)
    .force("link", d3.forceLink(links).id(d => d.id).distance(0).strength(1))
    .force("charge", d3.forceManyBody().strength(-50))
    .force("x", d3.forceX())
    .force("y", d3.forceY());

let svg = d3.select("svg"),
    width = +svg.attr("width"),
    height = +svg.attr("height");

const link = svg.append("g")
    .attr("stroke", "#999")
    .attr("stroke-opacity", 0.6)
    .selectAll("line")
    .data(links)
    .join("line");

const node = svg.append("g")
    .attr("fill", "#fff")
    .attr("stroke", "#000")
    .attr("stroke-width", 1.5)
    .selectAll("circle")
    .data(nodes)
    .join("circle")
    .attr("fill", d => d.children ? null : "#000")
    .attr("stroke", d => d.children ? null : "#fff")
    .attr("r", 3.5)
    .call(drag(simulation));

node.append("title")
    .text(d => d.data.name);

simulation.on("tick", () => {
    link
        .attr("x1", d => d.source.x)
        .attr("y1", d => d.source.y)
        .attr("x2", d => d.target.x)
        .attr("y2", d => d.target.y);

    node
        .attr("cx", d => d.x)
        .attr("cy", d => d.y);
});

invalidation.then(() => simulation.stop());

return svg.node();
}
