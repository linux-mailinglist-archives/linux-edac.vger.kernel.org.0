Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B4C3EEB3F
	for <lists+linux-edac@lfdr.de>; Tue, 17 Aug 2021 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhHQKwr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Aug 2021 06:52:47 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:40608
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232871AbhHQKwr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Aug 2021 06:52:47 -0400
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 390B840C9D
        for <linux-edac@vger.kernel.org>; Tue, 17 Aug 2021 10:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629197533;
        bh=LKaXRo21OcPl7oW6eAQ1RrxkFLgkIRdKzJxpZq0xTkg=;
        h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=V73kqG4muoPwCOnUw56EbZy+669hHgmCqZtteuqzwZN6uaq/LCGFBEs1DDj9IN+PD
         QXKntUtwLrY+CzWiThmOOPZ6tw5McxzsHRN1rxyYAOIFcbcD7Vb24LyvGvH29w11E+
         8sYznz/xgtW8ib/JXyshxcB2IouBehl8c0DhuhGbyp0hY/8k8fygPt5K5FdHGcFxjm
         jIOjtX52SFbaBznw4mFC8exwDYWzTsFJeCtU7lRS8XKagg5QciMQrnuc82c7aMCbTj
         q6zXdeD1wqBF9ymh1JGalqWxK2izDdufOCm6fTbJI2d4aufEYRlVlH/g8PtCyLBRiX
         5Mw7ViKlJ4iLQ==
Received: by mail-ej1-f69.google.com with SMTP id h22-20020a170906719600b005bc74a33a63so1961037ejk.8
        for <linux-edac@vger.kernel.org>; Tue, 17 Aug 2021 03:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LKaXRo21OcPl7oW6eAQ1RrxkFLgkIRdKzJxpZq0xTkg=;
        b=TxZxaWRFvYlpFn/5FM/ejceARiAVHVHeqKrqsIcNB4CD/b0gOR8+YYZ4DB/q3eRSIO
         jc/a8mY2OCqMapFU6WYUqlJfdpm0T7WRhCzpgjadTpcNZadXQINqBiqmvyPfJJtlvYWM
         eCUiDVsd3fkRjm1HAstpVKUxaDqytTb1W8MgiJk8GLYHt+W8Zu9uslv3lCjIrE+jLQJL
         bC3ZqjB0kY2Aqw7uAe4neOguAv7oipGkZzav+FcL0e/W/cUfiuaEs5csTlR0ngMC/j+h
         otTaOXpCktZd3qjGo0KoplaGkHwQnvag75enbKzziJIsiOBS5E7he0Dcok0tCCVVf43/
         2piQ==
X-Gm-Message-State: AOAM5305p5K47QalGVjWax8OmclUNU34xpYlBW+1lhUlRG9Q1cox8JTY
        hkwxV/U0hTRKy7ah5XKulI5SRCxTay2CXu8xi3ZhzQA84FZ1i1N66xb7jcAQ4bdoxNNAEf2Zlfc
        5ECtnVsznlA5f0fiPGHA4FEtOk5yNJkEuWmp6lrA=
X-Received: by 2002:a17:906:90d9:: with SMTP id v25mr3200903ejw.221.1629197532753;
        Tue, 17 Aug 2021 03:52:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaSmdC9DkBVW1PKygTj3vrq5nKED5BEBd5VhZRwJG1BXjzf7YAVljIDQcOZ2RweLbk5jWMag==
X-Received: by 2002:a17:906:90d9:: with SMTP id v25mr3200880ejw.221.1629197532455;
        Tue, 17 Aug 2021 03:52:12 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id ec49sm869824edb.54.2021.08.17.03.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 03:52:12 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: memory: convert Marvell MVEBU SDRAM
 controller to dtschema
To:     =?UTF-8?Q?Jan_L=c3=bcbbe?= <jlu@pengutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
References: <20210817093807.59531-1-krzysztof.kozlowski@canonical.com>
 <17798cb01c5d699738f57118d4deb53504759818.camel@pengutronix.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <9872ed05-28d6-15aa-dc61-228776d20819@canonical.com>
Date:   Tue, 17 Aug 2021 12:52:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <17798cb01c5d699738f57118d4deb53504759818.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 17/08/2021 12:46, Jan Lübbe wrote:
> On Tue, 2021-08-17 at 11:38 +0200, Krzysztof Kozlowski wrote:
>> Convert Marvell MVEBU SDRAM controller bindings to DT schema format
>> using json-schema.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../marvell,mvebu-sdram-controller.yaml       | 31 +++++++++++++++++++
>>  .../mvebu-sdram-controller.txt                | 21 -------------
>>  2 files changed, 31 insertions(+), 21 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml b/Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
>> new file mode 100644
>> index 000000000000..14a6bc8f421f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
>> @@ -0,0 +1,31 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/memory-controllers/marvell,mvebu-sdram-controller.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Marvell MVEBU SDRAM controller
>> +
>> +maintainers:
>> +  - Jan Luebbe <jlu@pengutronix.de>
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: marvell,armada-xp-sdram-controller
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    memory-controller@1400 {
>> +        compatible = "marvell,armada-xp-sdram-controller";
>> +        reg = <0x1400 0x500>;
>> +    };
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt b/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
>> deleted file mode 100644
>> index 89657d1d4cd4..000000000000
>> --- a/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
>> +++ /dev/null
>> @@ -1,21 +0,0 @@
>> -Device Tree bindings for MVEBU SDRAM controllers
>> -
>> -The Marvell EBU SoCs all have a SDRAM controller. The SDRAM controller
>> -differs from one SoC variant to another, but they also share a number
>> -of commonalities.
>> -
>> -For now, this Device Tree binding documentation only documents the
>> -Armada XP SDRAM controller.
> 
> Please keep the description, otherwise it would be confusing why the binding is
> named marvell,mvebu-sdram-controller.yaml although it (currenly) only applies to
> the Armada XP.
> 

The description does not explain why it only documents Armada XP, so it
just duplicates what is in "compatible" part of bindings. How is the
confusion removed by saying "we document currently only Armada XP"? What
changes?

The entire description (with first paragraph) might make it a derivative
work, so I would need Ack or SoB from author to relicense it (Cc: Thomas
Petazzoni).


Best regards,
Krzysztof
