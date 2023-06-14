Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E05272F723
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jun 2023 09:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbjFNH7P (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Jun 2023 03:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjFNH7O (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Jun 2023 03:59:14 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C4F10DA
        for <linux-edac@vger.kernel.org>; Wed, 14 Jun 2023 00:59:12 -0700 (PDT)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CFDD73F180
        for <linux-edac@vger.kernel.org>; Wed, 14 Jun 2023 07:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686729549;
        bh=rH99kLgOd0nw3NlgxGmEp/5xDqohv+MhP0ukWnkRMoc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=UrIHLKLn69EPsMNMd/gpy/Dwy3vCWxKu90m+HFeB7sR1nYVDbMOQ7Zi94ejNGSUfj
         MqTYVioR6rTUe+RxkgE1kdOiw102S4xEcvkZuxTNJmtyd9aKkk8i8TDrN5EgV+Fo+O
         CQqfXvi6z5+3N+i9dG2Sd9u1FZg6n5bBVKA1oKzieUbsBrT3IlhtD8W6+QREK3ZUTj
         k4MjbBlYJ4mens0X6+rCUDL9DQMNfbQVCAa4ul/iUD1oPDDZ3P5ecV5uFFxB4NWROy
         +rmf4g697IKSl7DXf+0Ee207YYzjr1pdAxILwoda1HuYcLdmeSca3CAoi6H4pVfIqa
         xWzGzxjF7Kgig==
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-39a9cefa414so4784180b6e.0
        for <linux-edac@vger.kernel.org>; Wed, 14 Jun 2023 00:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686729548; x=1689321548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rH99kLgOd0nw3NlgxGmEp/5xDqohv+MhP0ukWnkRMoc=;
        b=GmtUk+yoWyguqtRecz1UJJRDK0vKYT4Osd611Fa7aoAjgiplB3ntQmXzuHz12/k8Px
         S9P4MzmKm7p44OFUTtcY46DKlm4y5o5JydTKSoAUNDvYw6oSQDORvmUKuen8GayGuRSe
         dKl80/JBCCUffecfSl0i/IYV3eIs0JMTZHCsMuu7r3zdhfl/55cywybCcxGnY+MsZkKo
         nn1hF2vT98clfZkqISM9NPD3aaobbShH/FGXEmmkeRbSzhjxoPY6QZ+Ewek0d2kvHrdm
         Tnz2RJNahkZghs80afLeobO9AT5P0yvwyGr6ghjJn8DpUZPQDUCq1xkk1D4rJO+Aqgmv
         UeEQ==
X-Gm-Message-State: AC+VfDxqHqhTO5rMoP/WfNcvCtyBiAWgZjKrjlxOxDjUY+0C8+Cb8zJy
        mOvQgBmbTWKofxrfwXcchufQpSk12ewtw9vCmHfx4GiTpf99Qk4x239VNXDC1tatrM2eBcTiL1v
        a2bQ++qT+5T7vwSknVkTdUOJSfP9GdDmnqfoKhznLRpORobGq0Ego06c=
X-Received: by 2002:a05:6808:23d4:b0:398:1151:a42d with SMTP id bq20-20020a05680823d400b003981151a42dmr12046549oib.24.1686729548855;
        Wed, 14 Jun 2023 00:59:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5R4nnffjm0l7juVJYTkx1zHnhw7GCtfI7fPojJw5AQK8hIv6+7u53q6hde9hskOJSsB+oqfPiHr7hOlYCaJu8=
X-Received: by 2002:a05:6808:23d4:b0:398:1151:a42d with SMTP id
 bq20-20020a05680823d400b003981151a42dmr12046532oib.24.1686729548684; Wed, 14
 Jun 2023 00:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230516033133.340936-1-kai.heng.feng@canonical.com>
 <IA1PR11MB61718EFB6DB1BF95CB1CEA5089799@IA1PR11MB6171.namprd11.prod.outlook.com>
 <SJ1PR11MB608384487F94EC485C91F47CFC799@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAAd53p56=CpWpPEOD2YdCneJX-XxO93MHMQHbLRB7VCYweW7SQ@mail.gmail.com>
In-Reply-To: <CAAd53p56=CpWpPEOD2YdCneJX-XxO93MHMQHbLRB7VCYweW7SQ@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 14 Jun 2023 15:58:56 +0800
Message-ID: <CAAd53p7rpY7uUE-zBQOy3XBmB_JO96qYxkSZr26nZ+qcdT=COA@mail.gmail.com>
Subject: Re: [PATCH] EDAC/Intel: Fix shift-out-of-bounds when DIMM/NVDIMM is absent
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "kao, acelan" <acelan.kao@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 17, 2023 at 3:49=E2=80=AFPM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Wed, May 17, 2023 at 1:13=E2=80=AFAM Luck, Tony <tony.luck@intel.com> =
wrote:
> >
> > >> [   13.875282] Hardware name: HP HP Z4 G5 Workstation Desktop PC/896=
2,
> > > > BIOS U61 Ver. 01.01.15 04/19/2023
> >
> >
> > >> When a DIMM slot is empty, the read value of mtr can be 0xffffffff, =
therefore
> >
> > > Looked like a buggy BIOS/hw that didn't set the mtr register.
> > >
> > > 1. Did you print the mtr register whose value was 0xffffffff?
> > > 2. Can you take a dmesg log with kernel "CONFIG_EDAC_DEBUG=3Dy" enabl=
ed?
> > > 3. What was the CPU? Please take the output of "lscpu".
> > > 4. Did you verify your patch that the issue was fixed on your systems=
?
> >
> > I wonder if BIOS is "hiding" some devices from the OS? The 0xffffffff r=
eturn is
> > the standard PCI response for reading a non-existent register. But that=
 doesn't
> > quite make sense with having a "dimm present" bit in the MTR register. =
If
> > the register only exists if the DIMM is present, then there is no need =
for
> > a "dimm present" bit.
>
> I wonder if the "non-existent register" read is intended?
>
> >
> > Some "lspci" output may also be useful.
>
> lspci can be found in [1]:
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217453

A gentle ping...

>
> Kai-Heng
>
> >
> > -Tony
