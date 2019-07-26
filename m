Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 927B576C07
	for <lists+linux-edac@lfdr.de>; Fri, 26 Jul 2019 16:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfGZOvV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Jul 2019 10:51:21 -0400
Received: from foss.arm.com ([217.140.110.172]:45788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbfGZOvV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 26 Jul 2019 10:51:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6476D337;
        Fri, 26 Jul 2019 07:51:18 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E782E3F71F;
        Fri, 26 Jul 2019 07:51:16 -0700 (PDT)
Subject: Re: [PATCH v9 8/8] EDAC: armada_xp: Add support for more SoCs
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     bp@alien8.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, patches@armlinux.org.uk, mchehab@kernel.org,
        jlu@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
 <20190712034904.5747-9-chris.packham@alliedtelesis.co.nz>
From:   James Morse <james.morse@arm.com>
Message-ID: <128016c1-380f-70c4-3a89-2d3b0edf9f88@arm.com>
Date:   Fri, 26 Jul 2019 15:51:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712034904.5747-9-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Chris,

On 12/07/2019 04:49, Chris Packham wrote:
> The Armada 38x and other integrated SoCs use a reduced pin count so the
> width of the SDRAM interface is smaller than the Armada XP SoCs. This
> means that the definition of "full" and "half" width is reduced from
> 64/32 to 32/16.

> diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
> index 3759a4fbbdee..7f227bdcbc84 100644
> --- a/drivers/edac/armada_xp_edac.c
> +++ b/drivers/edac/armada_xp_edac.c
> @@ -332,6 +332,11 @@ static int axp_mc_probe(struct platform_device *pdev)
>  
>  	axp_mc_read_config(mci);
>  
> +	/* These SoCs have a reduced width bus */
> +	if (of_machine_is_compatible("marvell,armada380") ||
> +	    of_machine_is_compatible("marvell,armadaxp-98dx3236"))
> +		drvdata->width /= 2;

So the hardware's SDRAM_CONFIG_BUS_WIDTH value is wrong? Yuck.

Is it too late for the DTs on these two systems to provide a DT version of the 'bus_width'
to override the hardware's mis-advertised value?

This way you don't need to grow this list.

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
