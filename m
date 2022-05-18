Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA6952B18B
	for <lists+linux-edac@lfdr.de>; Wed, 18 May 2022 06:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiEREdm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 May 2022 00:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiEREdi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 May 2022 00:33:38 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268FF1130;
        Tue, 17 May 2022 21:33:36 -0700 (PDT)
Received: from [172.24.65.115] (edu241124.nat.uni-leipzig.de [139.18.241.124])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4DAF361EA192A;
        Wed, 18 May 2022 06:33:34 +0200 (CEST)
Message-ID: <564c41fe-08cc-9c19-1506-c7b501458251@molgen.mpg.de>
Date:   Wed, 18 May 2022 06:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v9 2/3] dt-bindings: edac: nuvoton: add NPCM memory
 controller
Content-Language: en-US
To:     Medad Young <medadyoung@gmail.com>
Cc:     rric@kernel.org, James Morse <james.morse@arm.com>,
        tony.luck@intel.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING <KFTING@nuvoton.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>, ctcchien@nuvoton.com,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
References: <20220510031056.1657-1-ctcchien@nuvoton.com>
 <20220510031056.1657-3-ctcchien@nuvoton.com>
 <8d46eeb8-7926-f842-6105-1975a5adc3fe@molgen.mpg.de>
 <CAHpyw9cvrEKMUpRBWYWp9hDZgA8ALHBkNAQr6ZDqjj4uH-MRTQ@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAHpyw9cvrEKMUpRBWYWp9hDZgA8ALHBkNAQr6ZDqjj4uH-MRTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Dear Medad,


Am 16.05.22 um 04:30 schrieb Medad Young:

> Paul Menzel 於 2022年5月10日 週二 下午2:14寫道：

>> Am 10.05.22 um 05:10 schrieb Medad CChien:
>>> Document devicetree bindings for the Nuvoton BMC NPCM memory controller.
>>>
>>> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>> ---
>>>    .../edac/nuvoton,npcm-memory-controller.yaml  | 61 +++++++++++++++++++
>>>    1 file changed, 61 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
>>> new file mode 100644
>>> index 000000000000..6f37211796a3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
>>> @@ -0,0 +1,61 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/edac/nuvoton,npcm-memory-controller.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Nuvoton NPCM Memory Controller
>>> +
>>> +maintainers:
>>> +  - Medad CChien <ctcchien@nuvoton.com>
>>
>> Just a side note, that in my experience functional like
>> <linux-npcm-memory-controller@nuvoton.com> instead of personal addresses
>> are useful, as you can configure on your side, who to deliver messages
>> to. For example, if you are on sick leave or vacation, you just
>> configure to deliver the message to a colleague of yours (or they get
>> messages in the first place anyway).
>>
>> Maybe you can bring that up at Nuvoton.
> 
> I understand, but we do not have group email  address.
> so maybe I should add more maintainers?

If there are actually more maintainers, responsible and knowledgeable 
for that driver, than yes, these should be added (until you get a 
function address set up).


Kind regards,

Paul
