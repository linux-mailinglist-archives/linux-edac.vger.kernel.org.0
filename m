Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0001E7D130D
	for <lists+linux-edac@lfdr.de>; Fri, 20 Oct 2023 17:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377696AbjJTPl6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Oct 2023 11:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377678AbjJTPl5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 20 Oct 2023 11:41:57 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C52AAB
        for <linux-edac@vger.kernel.org>; Fri, 20 Oct 2023 08:41:55 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C417940E0187;
        Fri, 20 Oct 2023 15:41:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZaaxVINky5y6; Fri, 20 Oct 2023 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697816512; bh=v6q1prh4AO7gNw7IBDyDlsr9AgEZ+vfPYrPUFaD0UUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYAZEHTNcnmIp4/4Cn3xc7fh+FUYEFGwIyQKINTBICHmnKJXieeH3+zhi3O0hNoQF
         vTAgijkUzTP4TlVadHVjTobUweonRGLvDWmMtB21VcSSAgL+io71ueQ1EUbOohu97w
         ohF4buyL7QanfHGkfj862F27SsRO9qIu3w3XzDIWHC0So6FAw5JC+ZJwhihdS6sqcf
         SSLGh78PbBlY3XocNx39vIAt6jbY2sdiP3rtytWVrSZGY7JWFygs2LO2o7vzrXLlCP
         NX83913WUFRl85yL4YH4oTb+5LLByXJNtz0qgePlLvyDKrzhqlf58oGneN2SMZS5OH
         KNklaszz5M3vZ0SyT1feHW1LMGeRbZKFO9j/DG5EjWc9ZSFqDYQVri52PHVIrZLyo2
         TsHiu9PgEE8gEA+rUiEilyvj7DO4nCJi/mlDUjxIYJue9kkv5kCq1efEb3YFPfZBJr
         dOledOphE5ld+fTrQepxgSnptALbtkXIG7lSF0NN+YB/jOM1xarajmrKwOdjqoIFmm
         lvjqWueAeRayqu1tmFZ8anLhnrm2o1pbRz4rdu6maB5xjU3lIZcFxtpPLvO3t4UG0W
         Sl6eoB+Jm0otAxkKzWhFkHa1dbOWMgVBLUaVXESdm6l0xgNWFeMyxqPO7T03abW/qo
         aiAMpDgr4q09egtU5MhrGEOU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F380D40E014B;
        Fri, 20 Oct 2023 15:41:48 +0000 (UTC)
Date:   Fri, 20 Oct 2023 17:41:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     shubhrajyoti.datta@amd.com, linux-edac@vger.kernel.org
Subject: Re: [bug report] EDAC/versal: Add a Xilinx Versal memory controller
 driver
Message-ID: <20231020154142.GFZTKftpt4HTM4tpkH@fat_crate.local>
References: <a4db6f93-8e5f-4d55-a7b8-b5a987d48a58@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4db6f93-8e5f-4d55-a7b8-b5a987d48a58@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 20, 2023 at 04:45:57PM +0300, Dan Carpenter wrote:
> Hello Shubhrajyoti Datta,
> 
> The patch 0fd934580ea3: "EDAC/versal: Add a Xilinx Versal memory
> controller driver" from Oct 5, 2023 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	drivers/edac/versal_edac.c:967 mc_probe()
> 	warn: unsigned 'edac_mc_id' is never less than zero.

I guess something like this ontop:

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 08f630185913..87e730dfefa0 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -962,10 +962,8 @@ static int mc_probe(struct platform_device *pdev)
 	if (!get_ecc_state(ddrmc_baseaddr))
 		return -ENXIO;
 
-	/* Allocate ID number for our EMIF controller */
+	/* Allocate ID number for the EMIF controller */
 	edac_mc_id = emif_get_id(pdev->dev.of_node);
-	if (edac_mc_id < 0)
-		return -EINVAL;
 
 	regval = readl(ddrmc_baseaddr + XDDR_REG_CONFIG0_OFFSET);
 	num_chans = FIELD_PREP(XDDR_REG_CONFIG0_NUM_CHANS_MASK, regval);

---

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
