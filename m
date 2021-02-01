Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B9B30A715
	for <lists+linux-edac@lfdr.de>; Mon,  1 Feb 2021 13:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhBAMDb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 1 Feb 2021 07:03:31 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49341 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhBAMDa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 1 Feb 2021 07:03:30 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l6Xsl-0005jO-HT; Mon, 01 Feb 2021 13:00:39 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l6Xsj-0000et-PI; Mon, 01 Feb 2021 13:00:37 +0100
Date:   Mon, 1 Feb 2021 13:00:37 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-edac@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        York Sun <york.sun@nxp.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: arm: cpus: Add edac-enabled property
Message-ID: <20210201120037.GQ19583@pengutronix.de>
References: <20210201115753.18349-1-s.hauer@pengutronix.de>
 <20210201115753.18349-3-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201115753.18349-3-s.hauer@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:59:46 up 61 days, 26 min, 101 users,  load average: 0.17, 0.07,
 0.06
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 01, 2021 at 12:57:53PM +0100, Sascha Hauer wrote:
> Some CPUs like the Cortex-A53 and Cortex-A57 have Error Detection And
> Correction (EDAC) support on their L1 and L2 caches. This is implemented
> in implementation defined registers, so usage of this functionality is
> not safe in virtualized environments or when EL3 already uses these
> registers.
> This patch adds a edac-enabled flag which can be explicitly set when
> EDAC can be used.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
>  drivers/edac/cortex_arm64_l1_l2.c               | 7 +++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index f02fd10de604..80dcf90f3e78 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -269,6 +269,12 @@ properties:
>        For PSCI based platforms, the name corresponding to the index of the PSCI
>        PM domain provider, must be "psci".
>  
> +  edac-enabled:
> +    $ref: '/schemas/types.yaml#/definitions/flag'
> +    description:
> +      Some CPUs support Error Detection And Correction (EDAC) on their L1 and
> +      L2 caches. This flag marks this function as usable.
> +
>    qcom,saw:
>      $ref: '/schemas/types.yaml#/definitions/phandle'
>      description: |
> diff --git a/drivers/edac/cortex_arm64_l1_l2.c b/drivers/edac/cortex_arm64_l1_l2.c
> index 3b1e2f3ccab6..6d5355bae80c 100644
> --- a/drivers/edac/cortex_arm64_l1_l2.c
> +++ b/drivers/edac/cortex_arm64_l1_l2.c
> @@ -190,8 +190,11 @@ static int __init cortex_arm64_edac_driver_init(void)
>  	for_each_possible_cpu(cpu) {
>  		np = of_get_cpu_node(cpu, NULL);
>  
> -		if (of_match_node(cortex_arm64_edac_of_match, np))
> -			cpumask_set_cpu(cpu, &compat_mask);
> +		if (!of_match_node(cortex_arm64_edac_of_match, np))
> +			continue;
> +		if (!of_property_read_bool(np, "edac-enabled"))
> +			continue;
> +		cpumask_set_cpu(cpu, &compat_mask);

Hum, this should be in patch 1/2 of course.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
