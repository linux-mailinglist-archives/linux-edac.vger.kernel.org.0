Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073486E7CC4
	for <lists+linux-edac@lfdr.de>; Wed, 19 Apr 2023 16:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjDSOdg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Apr 2023 10:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjDSOdg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 19 Apr 2023 10:33:36 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F3ABBBE
        for <linux-edac@vger.kernel.org>; Wed, 19 Apr 2023 07:33:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso2345473wmo.0
        for <linux-edac@vger.kernel.org>; Wed, 19 Apr 2023 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681914792; x=1684506792;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PDz5wPoF6mzki4uB+KT49albEFl80CleY3DhTbU8L2w=;
        b=Z++1M0L8+XjbKDxJ+5jLQ1ulABYi5IrM3t5phLmdBNgqjn81Lkb2LIp7FSGUmsNb+M
         JHuwtcVLu0m5djow1Hg0/b0/nFVeNDqtkrsfRrBHfdCrCh+hKaOUs2FrCXtHajsp6Z9v
         rIaJXNoh4MefZnAeV764MV72uGPrjvgfy5Rw11cXLmgmY/ERQL6XCMwXcXq+IxUWdd10
         LqgziErqQeqP3w7x0iLIpkdZctdgM83xeMFZ/XWW99CSv67HuSc4TcmruB1ZyH0I1pPJ
         4VxW13O4HjMtrK0nj4rGHZM2V0U303KzJXs5j452O7cyFfDK8n1qafAKRoDigP/+Odic
         mQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681914792; x=1684506792;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDz5wPoF6mzki4uB+KT49albEFl80CleY3DhTbU8L2w=;
        b=jjG/NTmhHWBaYjI3eOt4qlFX9NckxDuZdOHOCLkkIMixto95P5bjmusnlRCCrg0GMT
         T3e0+5u+gn20trfMrmgUVbhM8r2XJUKHzTkhPT7paCiBL3MP9OIL5p6AnI3Mc4hlgNNi
         hk7bHj92WBqesgB7M5DMz9evdJVt+vTZcmkkouasgILGymr+sYixus++9h/RInnglLZb
         afYNJN+6lgBU2hN4pQIeQ4oqRjJdepkUZTgXoVIthOsEQMx/362YjPYxwOetqo9ugQW5
         N1Hy4eNgDpVzip4Ge8dPk2Fk7e0cataOb5rLGH/HdmS85BXke7HzbEgUFfJHfjCsSBSK
         1qUQ==
X-Gm-Message-State: AAQBX9e6bnNcZrENTq3oVE04ua9Xzu57WPP71KDZ1k4UZjNtHNKSeaFT
        YgN9/t3Elpw8dwtnTvWaw6hGPummv/WjJ4YGGFA4Hlko
X-Google-Smtp-Source: AKy350YxycphWPSIxU0WlcO3m9WQwKv3e1t+Dkir0iCpMfZ+j4GbdbPfsoS72IIw+oop73NCEUIy/Q==
X-Received: by 2002:a7b:ce99:0:b0:3f1:75b3:60dd with SMTP id q25-20020a7bce99000000b003f175b360ddmr7275341wmj.22.1681914792066;
        Wed, 19 Apr 2023 07:33:12 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c000900b003f0aa490336sm2377802wmc.26.2023.04.19.07.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:33:11 -0700 (PDT)
Date:   Wed, 19 Apr 2023 17:33:08 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     thor.thayer@linux.intel.com
Cc:     linux-edac@vger.kernel.org
Subject: [bug report] EDAC/altera: Initialize peripheral FIFOs in probe()
Message-ID: <0a108941-4158-4dbe-a993-691c7c8fb338@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello Thor Thayer,

The patch 788586efd116: "EDAC/altera: Initialize peripheral FIFOs in
probe()" from Mar 26, 2019, leads to the following Smatch static
checker warning:

drivers/edac/altera_edac.c:1650 socfpga_init_sdmmc_ecc()
warn: inconsistent refcounting 'child->kobj.kref.refcount.refs.counter':
  inc on: 1646
  dec on: 1650

drivers/edac/altera_edac.c
    1624 static int __init socfpga_init_sdmmc_ecc(struct altr_edac_device_dev *device)
    1625 {
    1626         int rc = -ENODEV;
    1627         struct device_node *child;
    1628 
    1629         child = of_find_compatible_node(NULL, NULL, "altr,socfpga-sdmmc-ecc");
    1630         if (!child)
    1631                 return -ENODEV;
    1632 
    1633         if (!of_device_is_available(child))
    1634                 goto exit;
    1635 
    1636         if (validate_parent_available(child))
    1637                 goto exit;
    1638 
    1639         /* Init portB */
    1640         rc = altr_init_a10_ecc_block(child, ALTR_A10_SDMMC_IRQ_MASK,
    1641                                      a10_sdmmceccb_data.ecc_enable_mask, 1);
    1642         if (rc)
    1643                 goto exit;
    1644 
    1645         /* Setup portB */
    1646         return altr_portb_setup(device);

Should we call of_node_put() if altr_portb_setup() fails?

    1647 
    1648 exit:
    1649         of_node_put(child);
--> 1650         return rc;
    1651 }

regards,
dan carpenter
