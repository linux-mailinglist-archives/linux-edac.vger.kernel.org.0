Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA9241D8FE
	for <lists+linux-edac@lfdr.de>; Thu, 30 Sep 2021 13:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350522AbhI3LnT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 Sep 2021 07:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350490AbhI3LnT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 30 Sep 2021 07:43:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D70C06176A;
        Thu, 30 Sep 2021 04:41:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e1600628f023c6c6559e3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:1600:628f:23c:6c65:59e3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0E36F1EC0390;
        Thu, 30 Sep 2021 13:41:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633002095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zw4ZBpbNO4udwIPZnGBCbr91htBxnE2GelfY5GA0t18=;
        b=ghU4aYnGBnaV6bULPJzMBvLCHqvIoDgoheR+CWnXD6r4H3UkuUTJqh3v4QpGWhHTWgVT1q
        OV2PpZNxNqm6zRHPQqr3P9zaQneQJ0rDWi55y6AQVYyW18XQghXmXOb3iXv1J4r3oM+P0W
        1EZwr8iqLwyghF7rqpqUQEz/mF1y27Y=
Date:   Thu, 30 Sep 2021 13:41:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     michal.simek@xilinx.com, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCHv3 2/3] EDAC/synopsys: add support for version 3 of the
 Synopsys EDAC DDR
Message-ID: <YVWianHwt7P1LPY9@zn.tnic>
References: <20210928160423.271187-1-dinguyen@kernel.org>
 <20210928160423.271187-2-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210928160423.271187-2-dinguyen@kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 28, 2021 at 11:04:22AM -0500, Dinh Nguyen wrote:
> @@ -899,6 +930,10 @@ static const struct of_device_id synps_edac_match[] = {
>  		.compatible = "xlnx,zynqmp-ddrc-2.40a",
>  		.data = (void *)&zynqmp_edac_def
>  	},
> +	{
> +		.compatible = "snps,ddrc-3.80a",

WARNING: DT compatible string "snps,ddrc-3.80a" appears un-documented -- check ./Documentation/devicetree/bindings/
#169: FILE: drivers/edac/synopsys_edac.c:934:
+               .compatible = "snps,ddrc-3.80a",

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
