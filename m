Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761F64E55C2
	for <lists+linux-edac@lfdr.de>; Wed, 23 Mar 2022 16:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245299AbiCWP6Y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Mar 2022 11:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245298AbiCWP6X (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Mar 2022 11:58:23 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0884E7A9AB;
        Wed, 23 Mar 2022 08:56:54 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id k10so2100553oia.0;
        Wed, 23 Mar 2022 08:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IgrPCceiCwLycG0doYf+GNfBOLy+mSKqNNmNcIvAjl0=;
        b=1fFJ3gkknvNw/4X7Pz5iuOWnp3QU/qo/YRnNQ8V2rYpXjcqb7yU755xua4xd6pdzFW
         TajXqZSz3FI6of8bsItXQu1qZfNaV6OJK0IBRydG2tT4ts7kiYTPmi1uGHVivzpxFcnK
         hRFULlByVuAykRB1/0Bj5ul3WtIOuljr+obT6doyqceP616I9rU8WAGW+tKuH4b3auQF
         ORny3VzKm9J05siEmS0G42RGCiCqKqggK2QAlVnBy7F0V1KhYY8QRlEWhgvWUTZ4C2TT
         3Ma/o3T79jJD7RjIW37ZH8sk2lTDhdOe7DSiT7EQEUDhK7c3g3TGkVxTKJjRbGJYSkZo
         X38g==
X-Gm-Message-State: AOAM533Lf+cUC0P611rCHwHs5+ulWuZVM0WHAjSJVLjHbKsQmaO0d4dT
        JCQivfKnVPL81C4+Bf4P5v/PJSuuew==
X-Google-Smtp-Source: ABdhPJzGJohUCXKA2BUHvBwllauhSqeFTTmapJ+mhGNVtrmcSr4Eo0LvjG+iTbOZPmccBggq8FsfBA==
X-Received: by 2002:a05:6808:209e:b0:2da:4de9:e632 with SMTP id s30-20020a056808209e00b002da4de9e632mr359702oiw.214.1648051013312;
        Wed, 23 Mar 2022 08:56:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s38-20020a05683043a600b005cda8c77010sm147072otv.26.2022.03.23.08.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 08:56:52 -0700 (PDT)
Received: (nullmailer pid 4177743 invoked by uid 1000);
        Wed, 23 Mar 2022 15:56:50 -0000
Date:   Wed, 23 Mar 2022 10:56:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Medad CChien <medadyoung@gmail.com>
Cc:     james.morse@arm.com, benjaminfair@google.com,
        devicetree@vger.kernel.org, ctcchien@nuvoton.com,
        linux-kernel@vger.kernel.org, KFTING@nuvoton.com,
        linux-edac@vger.kernel.org, venture@google.com, yuenn@google.com,
        rric@kernel.org, robh+dt@kernel.org, JJLIU0@nuvoton.com,
        bp@alien8.de, tony.luck@intel.com, KWLIU@nuvoton.com,
        avifishman70@gmail.com, YSCHU@nuvoton.com, tmaimon77@gmail.com,
        openbmc@lists.ozlabs.org, tali.perry1@gmail.com, mchehab@kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: edac: nuvoton: add NPCM memory
 controller
Message-ID: <YjtDQu+R+eDQW76B@robh.at.kernel.org>
References: <20220322030152.19018-1-ctcchien@nuvoton.com>
 <20220322030152.19018-3-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322030152.19018-3-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 22 Mar 2022 11:01:51 +0800, Medad CChien wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM memory controller.
> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../edac/nuvoton,npcm-memory-controller.yaml  | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
