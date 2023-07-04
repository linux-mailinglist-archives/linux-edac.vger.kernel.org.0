Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695EE74685B
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 06:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGDE14 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 00:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjGDE1z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 00:27:55 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8112C107
        for <linux-edac@vger.kernel.org>; Mon,  3 Jul 2023 21:27:54 -0700 (PDT)
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 651383F16E
        for <linux-edac@vger.kernel.org>; Tue,  4 Jul 2023 04:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688444872;
        bh=m0rCEv/CsWJXjSYog6lgIFb5mJu+Vk0RYpsqlz5EQgw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=mct1QJWXui7o8rz8IqrYksf+2z+Z8hoc1Pf47AOW3WQBbRQoGzr+ekyLZVAnDHJxL
         wfJOG5gvdCxvIMea1fKvPzmd51lkx+WrN4fhG7RLe9dfpqVP1GLiVd/Uf4wrez1NHf
         ctrYKAfS1Fdu+a5OzJYNE2OKiZlA7uuYdTHEfKWEADwxjkaVfVD7dY1KvNW9FlHcLC
         3aPOIfYVbIo1hZFZiCAdfc4qFMEH0Avq7VkbbBCex+EQSan09r3aJVW0SeetwfcqMe
         2t48+cQOGI0eLZ0XmKkBfApot7RtkRgw4CdFppzkGDZRyHbu+L0/jvYMygWBzzbIFO
         C58E2U0zuLT5w==
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7675581a4afso366316985a.1
        for <linux-edac@vger.kernel.org>; Mon, 03 Jul 2023 21:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688444871; x=1691036871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0rCEv/CsWJXjSYog6lgIFb5mJu+Vk0RYpsqlz5EQgw=;
        b=WOPsg+H1lHgc9C7lkFq5keqtz0qFKKCtcp8WE61J3Pah+pQr9KY6/Ljna9OrNHvclt
         xSmh/B6MntK6Sp1JsMZhcZU/JpWlA8q2qEjKiTtcnYRBdj8PNKdNdut1TWwuwRV9nDDY
         DPIcUYa2T/csUDTiSFwLfvYvURnOsnD7HrzVm5e9n0FmoA9e0RGIx7dueV5H0ijfqctz
         DrryjIXl+2UBC+zaNd/2kvtRrH/cYKpjsf3dRaz0cyPwPoPcANf0/MTZMWt/4PvqrnnU
         VdrUfv710RywCjZluY/LvTLpR+FDBQcOzBFXifZJwISTbM/q9NFoOuIKpw2Hc3wzeqpQ
         RJ9A==
X-Gm-Message-State: ABy/qLbiQXcPII+G0lw5IY+qTi6T4fnSC4pSiHu7sV9WMYKUP0v8j34O
        f8IRnEPVCFUMvJQmO/emj3Zanw6nJgkiCENff11czRTOVxgBOmStDDAXrmXvkmXb6dCNioFtjiU
        W9Yrx7jkfq4iqdd97h3NKFhJfLu3N18fmJXtX+Zg5EcQdf3q+QUrGu+Q=
X-Received: by 2002:a05:620a:b5c:b0:767:5984:3ca7 with SMTP id x28-20020a05620a0b5c00b0076759843ca7mr6999500qkg.40.1688444871306;
        Mon, 03 Jul 2023 21:27:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHOsoF3MvuVfKPaOCOEnX8/u9de7EY76LvgJfQExxXORdqkpExnQsaMwauVJoTxReymyk+AkQdcliPNEhc8KR4=
X-Received: by 2002:a05:620a:b5c:b0:767:5984:3ca7 with SMTP id
 x28-20020a05620a0b5c00b0076759843ca7mr6999487qkg.40.1688444871081; Mon, 03
 Jul 2023 21:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230516033133.340936-1-kai.heng.feng@canonical.com>
 <IA1PR11MB61718EFB6DB1BF95CB1CEA5089799@IA1PR11MB6171.namprd11.prod.outlook.com>
 <SJ1PR11MB608384487F94EC485C91F47CFC799@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAAd53p56=CpWpPEOD2YdCneJX-XxO93MHMQHbLRB7VCYweW7SQ@mail.gmail.com> <CAAd53p7rpY7uUE-zBQOy3XBmB_JO96qYxkSZr26nZ+qcdT=COA@mail.gmail.com>
In-Reply-To: <CAAd53p7rpY7uUE-zBQOy3XBmB_JO96qYxkSZr26nZ+qcdT=COA@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 4 Jul 2023 12:27:39 +0800
Message-ID: <CAAd53p41Ku1m1rapeqb1xtD+kKuk+BaUW=dumuoF0ZO3GhFjFA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 14, 2023 at 3:58=E2=80=AFPM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Wed, May 17, 2023 at 3:49=E2=80=AFPM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > On Wed, May 17, 2023 at 1:13=E2=80=AFAM Luck, Tony <tony.luck@intel.com=
> wrote:
> > >
> > > >> [   13.875282] Hardware name: HP HP Z4 G5 Workstation Desktop PC/8=
962,
> > > > > BIOS U61 Ver. 01.01.15 04/19/2023
> > >
> > >
> > > >> When a DIMM slot is empty, the read value of mtr can be 0xffffffff=
, therefore
> > >
> > > > Looked like a buggy BIOS/hw that didn't set the mtr register.
> > > >
> > > > 1. Did you print the mtr register whose value was 0xffffffff?
> > > > 2. Can you take a dmesg log with kernel "CONFIG_EDAC_DEBUG=3Dy" ena=
bled?
> > > > 3. What was the CPU? Please take the output of "lscpu".
> > > > 4. Did you verify your patch that the issue was fixed on your syste=
ms?
> > >
> > > I wonder if BIOS is "hiding" some devices from the OS? The 0xffffffff=
 return is
> > > the standard PCI response for reading a non-existent register. But th=
at doesn't
> > > quite make sense with having a "dimm present" bit in the MTR register=
. If
> > > the register only exists if the DIMM is present, then there is no nee=
d for
> > > a "dimm present" bit.
> >
> > I wonder if the "non-existent register" read is intended?
> >
> > >
> > > Some "lspci" output may also be useful.
> >
> > lspci can be found in [1]:
> >
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217453
>
> A gentle ping...

Another gentle ping...

>
> >
> > Kai-Heng
> >
> > >
> > > -Tony
