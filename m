Return-Path: <linux-edac+bounces-8-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748597E965D
	for <lists+linux-edac@lfdr.de>; Mon, 13 Nov 2023 05:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB3D1F2113F
	for <lists+linux-edac@lfdr.de>; Mon, 13 Nov 2023 04:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DBF6AA2;
	Mon, 13 Nov 2023 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="F9WCGDd3"
X-Original-To: linux-edac@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F68BE6;
	Mon, 13 Nov 2023 04:54:30 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5A3171B;
	Sun, 12 Nov 2023 20:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1699851264;
	bh=avuGse/loF5UavLAxTW+7b8ie0FypFWWnYQuSnadlV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F9WCGDd3mTXiAxpDTnIuEH6GCdDcBqJ8HRo9d3CP1JuATdd3s5h4WmgzGrlS6+V4T
	 +3Y6ZkUZ26zUnEbmoOXPKgDr67l6EHlYxYzxEOaIc4JSKEc5ZVIw8sPcwS3/R/57im
	 aoZzWU3vWpXQCWkJc0pp22F4Agu9RKsibrWtG9HAXz8vpq/FvvyOSGWpB07aAznDQd
	 WWbwfbaRfNgvyFDqP6IFpcup8gRcTBaP+yExIM7DM0cgMAOILKznGMtLI1raWJVm87
	 AIbhGSi9YyfwcCZeCO9IWgrjURKeQXJXez+p1ZB2ch8hYH6WGVVBeM3caLCYVjl2Rt
	 rDWqyjf98KGyQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4STHCM4Bl6z4xTM;
	Mon, 13 Nov 2023 15:54:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-edac@vger.kernel.org
Cc: git@amd.com, devicetree@vger.kernel.org, sai.krishna.potthuri@amd.com,
 krzysztof.kozlowski@linaro.org, robh+dt@kernel.org, conor+dt@kernel.org,
 bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
 mchehab@kernel.org, rric@kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v9 2/2] EDAC/versal: Add a Xilinx Versal memory
 controller driver
In-Reply-To: <20231005101242.14621-3-shubhrajyoti.datta@amd.com>
References: <20231005101242.14621-1-shubhrajyoti.datta@amd.com>
 <20231005101242.14621-3-shubhrajyoti.datta@amd.com>
Date: Mon, 13 Nov 2023 15:54:23 +1100
Message-ID: <875y268d8g.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shubhrajyoti Datta <shubhrajyoti.datta@amd.com> writes:
> Add a EDAC driver for the RAS capabilities on the Xilinx integrated DDR
> Memory Controllers (DDRMCs) which support both DDR4 and LPDDR4/4X memory
> interfaces. It has four programmable NoC interface ports and is designed
> to handle multiple streams of traffic.The driver
> reports correctable and uncorrectable errors , and also creates
> debugfs entries for error injection.
...
> diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
> new file mode 100644
> index 000000000000..5ce2e9585a00
> --- /dev/null
> +++ b/drivers/edac/versal_edac.c
...
> +#define XDDR_REG_CONFIG0_NUM_CHANS_MASK		BIT(17)
...
> +static int mc_probe(struct platform_device *pdev)
> +{
> +	void __iomem *ddrmc_baseaddr, *ddrmc_noc_baseaddr;
> +	struct edac_mc_layer layers[2];
> +	struct mem_ctl_info *mci;
> +	u8 num_chans, num_csrows;
> +	struct edac_priv *priv;
> +	u32 edac_mc_id, regval;
> +	int rc;
> +
...
> +
> +	regval = readl(ddrmc_baseaddr + XDDR_REG_CONFIG0_OFFSET);
> +	num_chans = FIELD_PREP(XDDR_REG_CONFIG0_NUM_CHANS_MASK, regval);
 
Shouldn't this be FIELD_GET?

Otherwise it's shifting regval into BIT(17), and then assigning that to a u8.

> +	num_chans++;
> +
> +	num_csrows = FIELD_PREP(XDDR_REG_CONFIG0_NUM_RANKS_MASK, regval);
 
And here too?

> +	num_csrows *= 2;
> +	if (!num_csrows)
> +		num_csrows = 1;

cheers

