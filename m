Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2079E6574B1
	for <lists+linux-edac@lfdr.de>; Wed, 28 Dec 2022 10:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiL1Jfx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Dec 2022 04:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiL1Jfw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Dec 2022 04:35:52 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16701E1;
        Wed, 28 Dec 2022 01:35:49 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id 6so7217450vkz.0;
        Wed, 28 Dec 2022 01:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3sibGBIP0qfr15zCs+LR1FWj+O5p4xMBAwTb8KT3ZFo=;
        b=ElMpyQfw4EjT7pVErCiIjYzpl5WTibySHAZpxETa4BVArl7fsr9mjYahaMf6ueUx2c
         fEUyFA/phIDj0kaDm1T7kVDXym+9sfa+9uSKDBEqj5DZ9pql1gHqg0vlmt/JBBtGCYIu
         tznZtG8UmydP1EyOcSVE7mSEQgCf+gQTkUQFApLOspcKpw3NX0s0AmHkVGPTG2gUOEoX
         3LKwW5YdaA1BFznohGea70qC55P2RpSE7TCV2ZdAV54U5ivgkl8S0qcjl3lbWcSwOg7h
         8BNGsxMW8nQvtRBZO8WM+xUKQXXmUCjiUz/pAYHrogYIzMuDIFo5TduYS/h1w3+Eo5Wk
         9wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sibGBIP0qfr15zCs+LR1FWj+O5p4xMBAwTb8KT3ZFo=;
        b=nhCzcq/kN41EavFOGKtnZ3eppx8eX3Md94Qle8/970f6CqgyvfT5+U80ljJSTUQWlv
         62LxJ/Z6N2Xy/ETCQe2pexAoSgVpfdasUBYd0iX+PYxnQIcggExTaD0klIkDcWPJbJEC
         BVvrgeMtPeFirtJPQjlBpgCG+sRZkyk5FlUTxJWZ4/HdX2WdPPSfvesk8vmuDNWXQvZ1
         MUoRyuuLrG96sK8fmcZbOlaeAgdDzJunnvyjdYmbsqFDkiH5QidR17IVCdKdObE+uh4+
         k/eZeT6GjlLTNLEMthl3YUou6+J1eMdEaubUk/e4U4c/4uw1gh8byutbub788Uc3Ze9J
         faKA==
X-Gm-Message-State: AFqh2krCiOrzo4Pd4OnFyx0UJrDNi6iK0mBJrl4BvWizaXwOBycXeEgG
        eLM3hrsg6jA91287qVOCZDvxghIqtkzXvyH6dE8=
X-Google-Smtp-Source: AMrXdXu2vG/opw86gJxJic7D2pXoI0xu8KoLJ3tKlVtyUwLrpZVECwWc7O02O0XkPUZCRxdlL3IsKI++4Td+5L4funY=
X-Received: by 2002:a1f:a954:0:b0:3b8:ba98:bd43 with SMTP id
 s81-20020a1fa954000000b003b8ba98bd43mr2717589vke.34.1672220148952; Wed, 28
 Dec 2022 01:35:48 -0800 (PST)
MIME-Version: 1.0
References: <20221223032859.3055638-1-milkfafa@gmail.com> <20221223032859.3055638-3-milkfafa@gmail.com>
 <2a88ee33-91ab-431f-b9ce-472dc64f7430@linaro.org>
In-Reply-To: <2a88ee33-91ab-431f-b9ce-472dc64f7430@linaro.org>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Wed, 28 Dec 2022 17:35:37 +0800
Message-ID: <CADnNmFrchhZqv_KzXq1RGQXhFF5A8G_CkXzgT+7Rj+--7cfdtw@mail.gmail.com>
Subject: Re: [PATCH v17 2/3] dt-bindings: edac: nuvoton: Add document for NPCM
 memory controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, ctcchien@nuvoton.com,
        kflin@nuvoton.com, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> > Add dt-bindings document for Nuvoton NPCM memory controller.
>
> Subject: use "memory-controllers" prefix, not edac.

Thanks for the review. I'll correct it in the next patch.

Regards,
Marvin
