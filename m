Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5865D7D10BC
	for <lists+linux-edac@lfdr.de>; Fri, 20 Oct 2023 15:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377465AbjJTNqL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Oct 2023 09:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377468AbjJTNqJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 20 Oct 2023 09:46:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAE7D57
        for <linux-edac@vger.kernel.org>; Fri, 20 Oct 2023 06:46:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3296b49c546so584782f8f.3
        for <linux-edac@vger.kernel.org>; Fri, 20 Oct 2023 06:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697809562; x=1698414362; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHVhoC4aJNqHMdmaog4zjDlQuyve5LeloxRKNNeALag=;
        b=k1+SBx3nPRB/meL8xBfV9Tupf7q+vr65SGil5q7g4xzzjg6dxolbWXHlbPbKYov0aG
         8SYrVqEM//1O9t8ZQGq7AsRQ4PDcJ8bmxz18uh83bubyXYWNTAI5wNBj/LFhBwq+0i0s
         4meEPpEcPbsHpKLmYJ+mLuMFe4L3TcRDkuEDenpD+BGr1FmSDPVqNG8bsk2G119wXrkC
         ZS3CurIyPYaswC1RoPARISSibzX+YK7//i9y9JS40aDXywiKdiW255KGg+CIm/tT4Qs6
         JutbeyfQch11t8jV17VL+WEvblvIr6KNUb79sW6O/pkCwnRygY7IYqDlUHn0swAOU9MA
         39TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697809562; x=1698414362;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHVhoC4aJNqHMdmaog4zjDlQuyve5LeloxRKNNeALag=;
        b=XR/1vLP77uQH3Cya4UZht/qGoaENzw6vRWa6QX0zdJSMwVS5tpng2hjNZJy1RTDDod
         1OckXMZkGMj3Z6txqEV/QovKQywKge0IXoCX/1cvqkzMtrh+X+cmZUBVSIDcpodir4y+
         N9HKDn9vPlIVZZ6XbbhXtWm1jkIa50oezVr0x9s3S5cKIDleBucp9hVsiNwjdxcVS2IE
         UUHHQh73sHMC3A45iKZLmdBdMGUc6+XgECSUMrFkjCN78/I+MDZZAYhZ60kK5XFQeBkY
         H6luA8hFat0+LcduwkivNbj06fooJIFuReRbYXcv/RrQUNErMqKLfeOOxSRvt+RVaCJw
         enBA==
X-Gm-Message-State: AOJu0Ywv6QSIsrICCDOFBIlaQ/8VcmReLEP0OUj9CeJUhhv4nIn9kxzv
        N9Z8eiWU/ZV/rCefBC3VKdDTYQ==
X-Google-Smtp-Source: AGHT+IGp6O+0ki4n/9p7WUhIugUPiLy7GgW3aOtHkH6Fnhbyj2vPF2UxUu0DcoZpKbyZbB8kEByrAg==
X-Received: by 2002:adf:ec47:0:b0:32d:9718:b32a with SMTP id w7-20020adfec47000000b0032d9718b32amr1193218wrn.0.1697809562131;
        Fri, 20 Oct 2023 06:46:02 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n15-20020adfe78f000000b003197869bcd7sm1742635wrm.13.2023.10.20.06.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 06:46:01 -0700 (PDT)
Date:   Fri, 20 Oct 2023 16:45:57 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     shubhrajyoti.datta@amd.com
Cc:     linux-edac@vger.kernel.org
Subject: [bug report] EDAC/versal: Add a Xilinx Versal memory controller
 driver
Message-ID: <a4db6f93-8e5f-4d55-a7b8-b5a987d48a58@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello Shubhrajyoti Datta,

The patch 0fd934580ea3: "EDAC/versal: Add a Xilinx Versal memory
controller driver" from Oct 5, 2023 (linux-next), leads to the
following Smatch static checker warning:

	drivers/edac/versal_edac.c:967 mc_probe()
	warn: unsigned 'edac_mc_id' is never less than zero.

drivers/edac/versal_edac.c
    944 static int mc_probe(struct platform_device *pdev)
    945 {
    946         void __iomem *ddrmc_baseaddr, *ddrmc_noc_baseaddr;
    947         struct edac_mc_layer layers[2];
    948         struct mem_ctl_info *mci;
    949         u8 num_chans, num_csrows;
    950         struct edac_priv *priv;
    951         u32 edac_mc_id, regval;
                ^^^^^^^^^^^^^^

    952         int rc;
    953 
    954         ddrmc_baseaddr = devm_platform_ioremap_resource_byname(pdev, "base");
    955         if (IS_ERR(ddrmc_baseaddr))
    956                 return PTR_ERR(ddrmc_baseaddr);
    957 
    958         ddrmc_noc_baseaddr = devm_platform_ioremap_resource_byname(pdev, "noc");
    959         if (IS_ERR(ddrmc_noc_baseaddr))
    960                 return PTR_ERR(ddrmc_noc_baseaddr);
    961 
    962         if (!get_ecc_state(ddrmc_baseaddr))
    963                 return -ENXIO;
    964 
    965         /* Allocate ID number for our EMIF controller */
    966         edac_mc_id = emif_get_id(pdev->dev.of_node);
--> 967         if (edac_mc_id < 0)

emif_get_id() doesn't return error pointers and edac_mc_id is unsigned
so this won't work.

    968                 return -EINVAL;
    969 
    970         regval = readl(ddrmc_baseaddr + XDDR_REG_CONFIG0_OFFSET);
    971         num_chans = FIELD_PREP(XDDR_REG_CONFIG0_NUM_CHANS_MASK, regval);
    972         num_chans++;
    973 
    974         num_csrows = FIELD_PREP(XDDR_REG_CONFIG0_NUM_RANKS_MASK, regval);
    975         num_csrows *= 2;
    976         if (!num_csrows)
    977                 num_csrows = 1;

regards,
dan carpenter
