Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6EB4D625F
	for <lists+linux-edac@lfdr.de>; Fri, 11 Mar 2022 14:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiCKN3y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Mar 2022 08:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348876AbiCKN3x (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Mar 2022 08:29:53 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B405D5E1;
        Fri, 11 Mar 2022 05:28:48 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so6251315otl.6;
        Fri, 11 Mar 2022 05:28:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=DqWgVz4mscQx7VQZPkY837R3TSNSLttxQeZWV9I4qb4=;
        b=tI1D7Djk9/hipqQSZZhI5yR0TSGDEDK/6gDK02Mg6DDYkBBxzt5m/9N2UgG3Mrtou7
         OW90wZVr+FWmdYHxX+Pwrby7QsVwH1+Ahci7bJkoGajQpHADvYJsnUvdAuH8/dVxCppv
         ITs1Ev05yKzwYt5OZG30NOyf8jrxuJjLO/ZtbawliqH8am6zjn+F+8osoUQ7qpWmkCYz
         aXum3g3ZiuLREmMIL5T8pZz+A0AEEnqC6zAwJ+UXyydzwPKsPOhXl/PJ224BPBtnZGQd
         pMjdSjP/fOx5LBZCEO6T/Wxne7w9FgAtN9SrGJvqS60GZNu+a4aLEJSNsVPYb86LPArF
         +/iw==
X-Gm-Message-State: AOAM531u9cY1wMhV2ve6091KWC7GW15dCWiBKBqvJm76FMwHEbSLzlV8
        rq6OaYq0VYJ/WtHmmL56sg==
X-Google-Smtp-Source: ABdhPJyW3etsHadVks+qdx/NCSOI597tN0DpxS5HBRpw1Cqr6gc/YxuiIbex7hKaXujqBfrqa3jSPw==
X-Received: by 2002:a05:6830:438d:b0:5c4:f0f:70ac with SMTP id s13-20020a056830438d00b005c40f0f70acmr4240041otv.111.1647005327910;
        Fri, 11 Mar 2022 05:28:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r23-20020a056830237700b005b2610517c8sm3613104oth.56.2022.03.11.05.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 05:28:47 -0800 (PST)
Received: (nullmailer pid 3638165 invoked by uid 1000);
        Fri, 11 Mar 2022 13:28:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Medad CChien <medadyoung@gmail.com>
Cc:     tony.luck@intel.com, KWLIU@nuvoton.com, devicetree@vger.kernel.org,
        james.morse@arm.com, ctcchien@nuvoton.com, tali.perry1@gmail.com,
        robh+dt@kernel.org, JJLIU0@nuvoton.com, venture@google.com,
        mchehab@kernel.org, tmaimon77@gmail.com, yuenn@google.com,
        benjaminfair@google.com, avifishman70@gmail.com,
        linux-edac@vger.kernel.org, KFTING@nuvoton.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, YSCHU@nuvoton.com,
        rric@kernel.org, openbmc@lists.ozlabs.org
In-Reply-To: <20220311014245.4612-3-ctcchien@nuvoton.com>
References: <20220311014245.4612-1-ctcchien@nuvoton.com> <20220311014245.4612-3-ctcchien@nuvoton.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: edac: nuvoton,npcm-memory-controller.yaml
Date:   Fri, 11 Mar 2022 07:28:45 -0600
Message-Id: <1647005325.599595.3638164.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, 11 Mar 2022 09:42:44 +0800, Medad CChien wrote:
> Add device tree bindings for NPCM memory controller.
> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> ---
>  .../edac/nuvoton,npcm-memory-controller.yaml  | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/edac/nuvoton,npcm-memory-controller.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1604217

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

