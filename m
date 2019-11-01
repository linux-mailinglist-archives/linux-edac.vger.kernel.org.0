Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2C2ECA48
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2019 22:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfKAVaU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 1 Nov 2019 17:30:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40956 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfKAVaU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 1 Nov 2019 17:30:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id r4so7887934pfl.7;
        Fri, 01 Nov 2019 14:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j9Zzx2OmoZKK0YTGcIbk0+d45+ZuPxodkOVR0WatlxM=;
        b=b7NqdaJnjQ60mtJTxu02zhkyysPO6X9h9nBYWOZVeQfsqZMkp5udUkAUZuXMWY7m/K
         6kBCha9xyGlZPaZatv6dVbhxhl3E1MggDT9Nl/VZOTOZfWriIOqbFOSc40OCD7wQdKeJ
         ShiNr7fC4C5tcjhBH0o4QhPz6aiq8mWjk/fv6PlkxFpEr0XTUqBt7UWV6aJIBK+NZX+h
         4ndEV4cu6cXQ38GIkUUmpJ/aQtQpNJEl6t11YmzSc5fpvMvFOhzGgBkWx4rRkSHErEGP
         j1OIElbnrmkAJAsABdetec2iyugAh2KsQm/oI8IceArlB1i1m/nW3SoG9CTf+r0qHM1i
         THxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j9Zzx2OmoZKK0YTGcIbk0+d45+ZuPxodkOVR0WatlxM=;
        b=bldsAld2lIrWso5MneYUqsvl1tMwxUurXvbnz8YuETXQuGqmV7kKROC85Uj03nJ35p
         kw7TLVWUZ3LzUHSUV9+OSbNAhC28O/8NjdQK0FXUW2O8SBkcbLSRVyPrXxmA1oBFT1E0
         SWrYVJEu02SCkNhCs6AgKNV2fVIBCCdD7pjnmgQLI3JPo1B/qKequL7dVynjXYrNt4wD
         oUdr9X+VwKrNrI0MM7ORuk1TVU22k+aWuJu/QeeZsDCgRJQriBriJRIheuK4NiBkjwe+
         j+yJQHIuNJKBgXZwRvD3bRZFoeZ/1MICDF4O1TT/yDjM/8pLN265Enzo44rRfPnPYVhk
         XT8g==
X-Gm-Message-State: APjAAAWmSiqy2utvVdP9r4nQWIa7TnsVPlJPnwY2VXTP2J6B+RoZLplx
        14YS+/pMojL/mBvY9FZ4f8+PzdNGGRY=
X-Google-Smtp-Source: APXvYqzP5pCISaMJxKLrH+bSwSReGvtyfZ76m0aWat/GKZQJBZbiZYsCWgReTQKrrx4mtLs9p7ogJQ==
X-Received: by 2002:a62:61c4:: with SMTP id v187mr15954809pfb.23.1572643819363;
        Fri, 01 Nov 2019 14:30:19 -0700 (PDT)
Received: from [172.16.1.40] ([131.107.174.218])
        by smtp.gmail.com with ESMTPSA id h66sm9315173pfg.23.2019.11.01.14.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 14:30:18 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] dt-bindings: edac: arm-dmc520.txt
To:     Lei Wang <wangglei@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc:     "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "hangl@microsoft.com" <hangl@microsoft.com>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        "ruizhao@microsoft.com" <ruizhao@microsoft.com>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "yuqing.shen@broadcom.com" <yuqing.shen@broadcom.com>,
        "ray.jui@broadcom.com" <ray.jui@broadcom.com>, shji@microsoft.com
References: <BY5PR04MB6599EAA659A53B2331CB812586890@BY5PR04MB6599.namprd04.prod.outlook.com>
 <CAL_JsqJxcUr06+O_Ht5Kw0KXCWfSVC+6WMQqNxt-JehHh874hw@mail.gmail.com>
 <f4b2c4b9-4999-6736-31eb-a63781013664@gmail.com>
From:   Lei Wang <wangglei@gmail.com>
Message-ID: <7ea42556-49d4-5951-cda7-08e1209b0145@gmail.com>
Date:   Fri, 1 Nov 2019 14:30:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f4b2c4b9-4999-6736-31eb-a63781013664@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Rob,

Kindly ping... I addressed your comments in below, and with one=20
question. Thanks!

-Lei

On 10/25/19 10:31 AM, Lei Wang wrote:
> Thanks James/Rob/Borislav for pointing out the email list issue. My wor=
k=20
> email does not work good either for this exercise. Going forward I'll=20
> switch to my gmail account.
>=20
> And Thanks Rob for reviewing! Please see below.
>=20
>>> +++ b/Documentation/devicetree/bindings/edac/arm-dmc520.txt
>>> @@ -0,0 +1,26 @@
>>> +* ARM DMC-520 EDAC node
>>> +
>>> +Required properties:
>>> +- compatible=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : "brcm,dmc-520", "arm,dm=
c-520".
>>> +- reg=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : Address r=
ange of the DMC-520 registers.
>>> +- interrupts=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : DMC-520 interrupt numbe=
rs. The example=20
>>> below specifies
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 two interrupt lines for dram_ecc_errc_int and
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 dram_ecc_errd_int.
>>> +- interrupt-config=A0=A0=A0=A0 : This is an array of interrupt masks=
=2E For=20
>>> each of the
>>
>> Not a standard property, so would need a vendor prefix...
>=20
> Would dmc-interrupt-config as the property name work? Thanks!
>=20
>>
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 above interrupt line, add one interrupt=20
>>> mask element to
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 it. That is, there is a 1:1 mapping from=20
>>> each interrupt
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 line to an interrupt mask. An interrupt=20
>>> mask can represent
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 multiple interrupts being enabled. Refer to=20
>>> interrupt_control
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 register in DMC-520 TRM for interrupt=20
>>> mapping. In the example
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 below, the interrupt configuration enables=20
>>> dram_ecc_errc_int
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 and dram_ecc_errd_int. And each interrupt=20
>>> is connected to
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 a separate interrupt line.
>>
>> I've gone and read thru the TRM some. This binding doesn't seem to
>> correspond to the TRM at all. There are a bunch of interrupts and a
>> combined interrupt, and then there's the same set for 'overflow'
>> interrupts.
>>
>> There's only one 'interrupt_control' reg. How do you have more that 1
>> 32-bit value?
>=20
> There is only one 'interrupt_control' register, for multiple interrupt =

> sources. Then depending on platform hardware design, these interrupt=20
> sources can be wired to different physical interrupt lines.
>=20
> That is, it is possible to mux interrupt sources into=A0 interrupt line=
s=20
> for dmc520 in different ways. For example, in this particular brcm=20
> implementation,
>=20
> Line 841: source dram_ecc_errc_int
> Line 843: source dram_ecc_errd_int
> Line 839: source dram_ecc_errc_int and dram_ecc_errd_int
>=20
> There are two possibilities for implementing ecc counts for ce/ue. And =

> we chose to use the single source line: as below, two interrupt lines=20
> 0x349 and 0x34B, with interrupt masks 0x4 and 0x8 respectively.
>=20
> Also, it's possible to implement using the combined-source line too:=20
> that would be one interrupt line 0x347, with interrupt mask 0xC.
>=20
> This dt binding can support both by modifying the properties, without=20
> having to modify driver code.
>=20
>  >> +
>  >> +Example:
>  >> +
>  >> +dmc0: dmc@200000 {
>  >> +=A0=A0=A0=A0=A0=A0 compatible =3D "brcm,dmc-520", "arm,dmc-520";
>  >> +=A0=A0=A0=A0=A0=A0 reg =3D <0x200000 0x80000>;
>  >> +=A0=A0=A0=A0=A0=A0 interrupts =3D <0x0 0x349 0x4>, <0x0 0x34B 0x4>=
;
>  >> +=A0=A0=A0=A0=A0=A0 interrupt-config =3D <0x4>, <0x8>;
>  >> +};
>  >> --
>  >> 2.17.1
>=20
> Thanks!
>=20
> -Lei
>=20

