Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4297574A345
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jul 2023 19:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjGFRlG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jul 2023 13:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjGFRlF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jul 2023 13:41:05 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FD11BC9
        for <linux-edac@vger.kernel.org>; Thu,  6 Jul 2023 10:40:57 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C39D13F0F7
        for <linux-edac@vger.kernel.org>; Thu,  6 Jul 2023 17:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688665254;
        bh=m0o+bmo/z+KUHuCedyvvujwzX784WyikcaRwsI32unA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=U0WqcxbUwYjae6bpsM6cWIqH2gS57q5EHcrrztb0MqgcFBcXrOj4QhGS4DKiF61E1
         99LXSXSx/opUmaBx1Ni+9tovZ5BTiR9X2c0uWQpdmbGqWvaDXnvTqWgHS1nvIu3Ur2
         pyyYKwT355vI9W5XTf6sn9rhoEvlpFH5yXzkaatW9BysIxfYVE+dZyFufP248E/+QI
         jrayUCEXGfhImUo9m1s0i8vE39IlJIL6MEMcLrn+8DMhIqI/6vmzPv0WltILm1aDVZ
         vvkEA8mNoxqIY3DpxkUUaAE5lwoh2E/f5BOLS6yo90ykT9FCZwgKcw2IurHUxKFRPL
         7SupNcYYemEBQ==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-66a634b2cf5so1396635b3a.0
        for <linux-edac@vger.kernel.org>; Thu, 06 Jul 2023 10:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688665253; x=1691257253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0o+bmo/z+KUHuCedyvvujwzX784WyikcaRwsI32unA=;
        b=Z95OBs7VTPc5KSGH/+758mgnzPNPy1Zx7xbizVr9P9JIwSZRJWrcz8xrSyUT8efodI
         E4TWtPibGOi1zUbvZFrbjHx0Tq4JFWH7lpNl/QeAtqJzFgVmUdAQcL1slNELr1tNvpbl
         CYwv9aICLiZnX9+WptaBr5CLrINbAeLK+OQLgJ995cqEMe6G6gNp28gKCKZ1J58XL7e9
         GCn9ua9RrMWLsPCwBQ5+wbPlqSC/Bvc1jJg9lvoAoCrixeYcAxN5IO4SlPXgAoCH2SbL
         vCLkb5dhMFOL1TZwzYEbwnjjWVAQW5xYJEssc9BoCXk8W5azavv05AMRefsKu/jWLNu1
         91sA==
X-Gm-Message-State: ABy/qLaB8T0OzXiLeeM2iTsEnM63Ger1QjRDkzstswGqNMuLfsAO/U6N
        iZkpW1Y03xv5Y6y6HVviTTFX8xKBAw/fuRQ9mPjs6oPWOxo1nsQ6zBVloE67ekW86Wn75EXnUkw
        thzAvDAXMyygMCntq9O4JO67ynwn+M9n2UfXOhssVfhu6YfDBPvO8JE0=
X-Received: by 2002:a05:6a00:158a:b0:67f:830f:b809 with SMTP id u10-20020a056a00158a00b0067f830fb809mr4275354pfk.3.1688665252852;
        Thu, 06 Jul 2023 10:40:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEfcpCn1vj+9TsvflZJeswRHeXnGYuoBmqW8U19rZr8wbyUdHu3hpiKtpQVupOHiSFXNINbJmP+42FJI23Mhsk=
X-Received: by 2002:a05:6a00:158a:b0:67f:830f:b809 with SMTP id
 u10-20020a056a00158a00b0067f830fb809mr4275336pfk.3.1688665252541; Thu, 06 Jul
 2023 10:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230703162509.77828-1-koba.ko@canonical.com> <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
 <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+UB+eYoYOOVH2bqnnVEJcLrxaj5A7-zyfgBM7hOf4y8zw@mail.gmail.com>
 <SJ1PR11MB608383A5841E4AE8D3A64B79FC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+VFYyTiQ7yhX=Z8-Q4QW-GMsGXMuEWxLjuoZ1aDB98qXg@mail.gmail.com>
 <SJ1PR11MB60832C7FFEF98EE33F255B9DFC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CY8PR11MB713495A12DE47EDC3B7C5E20892CA@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB713495A12DE47EDC3B7C5E20892CA@CY8PR11MB7134.namprd11.prod.outlook.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Fri, 7 Jul 2023 01:40:40 +0800
Message-ID: <CAJB-X+X_KW=T4WOe2AS3SFFQKjt7VcQRFUCGYFcjipi5-aXdrw@mail.gmail.com>
Subject: Re: [PATCH v2] EDAC/i10nm: shift exponent is negative
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jul 6, 2023 at 10:12=E2=80=AFPM Zhuo, Qiuxu <qiuxu.zhuo@intel.com> =
wrote:
>
> > From: Luck, Tony <tony.luck@intel.com>
> > Sent: Wednesday, July 5, 2023 11:22 PM
> > ...
> > Subject: RE: [PATCH v2] EDAC/i10nm: shift exponent is negative
> >
> > >> # head /proc/cpuinfo
> >
> > This shows your system is the workstation version of Sapphire rapids. I=
 don't
> > think we did any validation of the EDAC driver against this model.
>
> No, we didn't do any validation of the EDAC on Sapphires Rapids workstati=
ons.
> From the link below, we know this is a Sapphire Rapids workstation with o=
nly 2 memory controllers.
> https://www.intel.com/content/www/us/en/products/sku/233480/intel-xeon-w3=
2435-processor-22-5m-cache-3-10-ghz/specifications.html
>
> We only did validation on the Sapphire Rapids servers which were with 4 m=
emory controllers per socket before.
>
> > > # dmidecode -t 17
> >
> > You have just one 16GB DIMM, and EDAC found that. So despite the messy
> > warnings, EDAC should be working for you.
> >
> > > # lspci
> >
> > I didn't dig into this. Qiuxu - can you compare this against a server S=
apphire
> > rapids?
> > Maybe it has some clues so the EDAC driver will know not to look for no=
n-
> > existent memory controllers.
>
> This Sapphire Rapids workstation had 2 memory controllers but appeared
> 4 memory controller PCIe devices from the log:
>
>     0000:fe:0c.0 1101: 8086:324a
>     0000:fe:0d.0 1101: 8086:324a // absent mc fooling the driver, should =
not appear
>     0000:fe:0e.0 1101: 8086:324a
>     0000:fe:0f.0 1101: 8086:324a // absent mc fooling the driver, should =
not appear
>
> By observing that the MMIO registers of these absent
> memory controllers consistently hold the value of ~0.
> We may identify a memory controller as absent by checking
> if its MMIO register "mcmtr" =3D=3D ~0 in all its channels.
>
> I made a patch below to skip all these absent memory controllers
> https://lore.kernel.org/linux-edac/20230706134216.37044-1-qiuxu.zhuo@inte=
l.com/T/#u
> @Koba Ko, could you please verify the patch from the link above on your w=
orkstation? Thanks!

Here's dmesg patched(Ref. 1). didn't find the previous message,
`EDAC DEBUG: skx_get_dimm_attr: bad ranks =3D 3 (raw=3D0xffffffff)`

Ref. 1, https://drive.google.com/drive/folders/1xym9JgZZgaJ3EqtP4ccRcVeQYoJ=
KmVlp?usp=3Dsharing

>
> BTW,
> Kai-Heng Feng also found the same issue before:
> https://lore.kernel.org/linux-edac/CAAd53p41Ku1m1rapeqb1xtD+kKuk+BaUW=3Dd=
umuoF0ZO3GhFjFA@mail.gmail.com/T/#m5de16dce60a8c836ec235868c7c16e3fefad0cc2
>
> - Qiuxu
