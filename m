Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CE15A6B92
	for <lists+linux-edac@lfdr.de>; Tue, 30 Aug 2022 20:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiH3SBQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 30 Aug 2022 14:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiH3SA6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 30 Aug 2022 14:00:58 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9849810F0;
        Tue, 30 Aug 2022 11:00:31 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-11f4e634072so4341418fac.13;
        Tue, 30 Aug 2022 11:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=4umf5P0qSFO98IiufExn5Sdnahshv3yBAldzEjgn0j4=;
        b=vqZe6YOFZrMyWSAYRghd+R3eCyO25rkIlLnzpKyq3Z8IDoZt8u3gNON0elk0hbuMG9
         RX4DLVQmHMVnIOdePS5dPMJj0KY1SANj/FMhAoR96F5iuwkM3jui3uzWbsA1pNyJn+Wq
         VpeXddjR72o+a4EcVye0pzRiJGV4bKJnQeXUxQAl+rvU16jTQs7I3A3trIaU4cKudo6v
         cJZdC0Yvlj8OypA9ywTmvqwZRlwMS1B2S+aL6lZM867Ct+Q3CekTnbNXzvHflWg0HHlb
         7mZvkY9KTmifEbIP7CG+kE3YDDe+ox1AllxMe6XUG27tZCJpE+5WtXBOCBwps3Sx3syT
         oNxw==
X-Gm-Message-State: ACgBeo2t8M1qatZKhF4ju1HeSMqnE9vBEIO+SshRO0k/Djg2ASLXN0W4
        lP8TqSrltIGjPsAwNilcqg==
X-Google-Smtp-Source: AA6agR5pm1v/qqg5BoLZtI0AcGW1KCa2e9nRD3jxB0Zc5BamYv40k7hzMg2PE3x0QwFLivkcj0gaGA==
X-Received: by 2002:a54:4496:0:b0:343:2d07:fe01 with SMTP id v22-20020a544496000000b003432d07fe01mr9350204oiv.226.1661882429847;
        Tue, 30 Aug 2022 11:00:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q17-20020a9d6551000000b006370c0e5be0sm7861506otl.48.2022.08.30.11.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:00:29 -0700 (PDT)
Received: (nullmailer pid 1763999 invoked by uid 1000);
        Tue, 30 Aug 2022 18:00:28 -0000
Date:   Tue, 30 Aug 2022 13:00:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 02/13] dt-bindings: memory: snps: Add Baikal-T1 DDRC
 support
Message-ID: <20220830180028.GA1758236-robh@kernel.org>
References: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
 <20220822191957.28546-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822191957.28546-3-Sergey.Semin@baikalelectronics.ru>
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

On Mon, Aug 22, 2022 at 10:19:45PM +0300, Serge Semin wrote:
> Baikal-T1 DDR controller is based on the DW uMCTL2 DDRC IP-core v2.51a
> with up to DDR3 protocol capability and 32-bit data bus + 8-bit ECC. There
> are individual IRQs for each ECC and DFI events.The dedicated scrubber
> clock source is absent since it's fully synchronous to the core clock.
> In addition to that the DFI-DDR PHY CSRs can be accessed via a separate
> registers space.

Are you sure the phy and dfi irq shouldn't be a separate device?

Rob
