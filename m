Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13EB509F7E
	for <lists+linux-edac@lfdr.de>; Thu, 21 Apr 2022 14:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383688AbiDUMVy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Apr 2022 08:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383743AbiDUMVx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 21 Apr 2022 08:21:53 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD07D2E09C;
        Thu, 21 Apr 2022 05:19:02 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-d39f741ba0so5169172fac.13;
        Thu, 21 Apr 2022 05:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Bkyl59+yJGYlxOaG8bBfXwq3Mtz9w1jqTJhIUpZWLg0=;
        b=WyuSLUeZD7PNGDOnQa4d6kLHCpfmyIVHkK20/jddjAOtyEAn17O5oQRxB+vVsQRzhY
         0RgQbtGVXZKD48a0zpcudkpWOAjKXmG4Kx65FUCpJzJdoSTL+IF1G+C1uUfb7Bf5YCNr
         HNlbPG5L+aibhDj5/eDQbR2ZIh7SkAA2KgRLzZ+R0VVmw5QeaO97kCwqrORGE/8U7Nb/
         N5waX8y3w8FGToBLaw0Ng7FKGaKt/Rx1JjoaLPYTItvo8zo/frT+ARqoZAxWt6w1Rozo
         6mgzAblk+2fLr6ONdt30YJtfLQY3D42z5EntEjuedkGpuKzb8QKFlv66r2bAmZCXtEX8
         D4pQ==
X-Gm-Message-State: AOAM533K5WZlm97L7L8fpu28aUxP7jL9exDD8xRYbCPSqUvpIA/opFm+
        585gR6DoP/GpwGdbyVRPgw==
X-Google-Smtp-Source: ABdhPJz96N7FmG2EahVdoLhvdwuy+bFDrSdoqpthix7QaE430aGKa4RhnG4KqOPXRu13Qv+Dq6w90g==
X-Received: by 2002:a05:6870:460f:b0:dd:cd0e:d931 with SMTP id z15-20020a056870460f00b000ddcd0ed931mr3869779oao.196.1650543542181;
        Thu, 21 Apr 2022 05:19:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fz13-20020a056870ed8d00b000e593f1f26fsm1023756oab.18.2022.04.21.05.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 05:19:01 -0700 (PDT)
Received: (nullmailer pid 3204418 invoked by uid 1000);
        Thu, 21 Apr 2022 12:19:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Medad CChien <medadyoung@gmail.com>
Cc:     tali.perry1@gmail.com, devicetree@vger.kernel.org,
        KWLIU@nuvoton.com, james.morse@arm.com, ctcchien@nuvoton.com,
        rric@kernel.org, avifishman70@gmail.com, openbmc@lists.ozlabs.org,
        JJLIU0@nuvoton.com, tmaimon77@gmail.com, tony.luck@intel.com,
        venture@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, benjaminfair@google.com, YSCHU@nuvoton.com,
        bp@alien8.de, linux-edac@vger.kernel.org, KFTING@nuvoton.com,
        mchehab@kernel.org, yuenn@google.com
In-Reply-To: <20220421062836.16662-3-ctcchien@nuvoton.com>
References: <20220421062836.16662-1-ctcchien@nuvoton.com> <20220421062836.16662-3-ctcchien@nuvoton.com>
Subject: Re: [PATCH v7 2/3] dt-bindings: edac: nuvoton: add NPCM memory controller
Date:   Thu, 21 Apr 2022 07:19:00 -0500
Message-Id: <1650543540.622713.3204417.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 21 Apr 2022 14:28:35 +0800, Medad CChien wrote:
> Document devicetree bindings for the Nuvoton BMC NPCM memory controller.
> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Borislav Petkov <bp@alien8.de>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  .../edac/nuvoton,npcm-memory-controller.yaml  | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml:61:7: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

