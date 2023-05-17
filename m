Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9517061AF
	for <lists+linux-edac@lfdr.de>; Wed, 17 May 2023 09:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjEQHuJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 May 2023 03:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjEQHtx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 May 2023 03:49:53 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1843D4EE7
        for <linux-edac@vger.kernel.org>; Wed, 17 May 2023 00:49:40 -0700 (PDT)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AB5153F4DF
        for <linux-edac@vger.kernel.org>; Wed, 17 May 2023 07:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684309778;
        bh=am/lQy0gekRHp1bKvU7D62NT+HZ4SISHKlUFomkzByY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=d6ArQtNGPFaws6l+mHV9b953tU5tusPzlwTdPa8r2THDUKe84glEDS+844drWKpnb
         5mChVH7Ur8RL/IzaOE9NZTXmTxjpWrQefEfZNsaC1M+9dH78MME0gLaF5JyFOyboU2
         AurBazLuydvbC03G3D5Wd0IM/TSvmM/wuNh8e1VEjgs6c7kwqgf67xgdBC1g2sWymD
         aNTJwSuIr+9vujSzGgWCuHDa9rpgAMYPoe/LEG+gP63Kx+buPFLV7wO5OhQ0pAw5oR
         OrSZ5GTRqBGQZnAkjXSW9sK6aHIzbE0yo1b14mTh6VsLIht7521TeR0QUBKPIA5ZJr
         6cKmSD0rJy9Uw==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-644c382a49aso301572b3a.2
        for <linux-edac@vger.kernel.org>; Wed, 17 May 2023 00:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684309777; x=1686901777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=am/lQy0gekRHp1bKvU7D62NT+HZ4SISHKlUFomkzByY=;
        b=Pa+3ChZcWpHJEH2D48v9+bw0sor30v24H02I7jm+rQndkA9S4Bj0lhE69FZKAuDdiB
         CwpV60CZWxY5lixnRla2Grmj97WMA8va10EtL6oBX1SCucqs1jFWmkLbg5R3YE46MPQv
         +t+B7AMCFNyCpGC4Sol34miAHGPsw5qIvKU3KXwLEMxuQpB6vBxNwEc2zL9+JXECGHGp
         cnjec69mT2RiJJG4LkE8owx9RyNu7qHE1QVxPMH980avzDoy3e4mw76IFmPJjMxqN9mq
         Cj+f5K6iEpICqpeFD672bnFx4KYjIg9lp9657LrS+3qbqAmapmImOpqPHffheMqc18vJ
         vhcQ==
X-Gm-Message-State: AC+VfDw9dKRH0dDDqhMP8z+wYo6es328mQ6U5MQtDpFBNQSPlJJsyxQK
        o6QSBgge1hq9r5E64Tjg+8piy4iCjWhd7ABBUYw38XyQNx0n6t6/CggrcIWyMjEoZyQ9LgzHAop
        m7V0Q0OyvlSUGs0IPg2xhjHNZRvHfYuEo0VjNn28OyuBimPUY4QfdiV8=
X-Received: by 2002:a05:6a00:2408:b0:643:aa2:4dd9 with SMTP id z8-20020a056a00240800b006430aa24dd9mr49908575pfh.7.1684309777266;
        Wed, 17 May 2023 00:49:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6VvAJDWc7mpXAm9F4cxKWCYX288vkxp71onlGSpaChEKBiCed2TETAdWOjbBwVhXLzWgYKJ/0NljXX+RUgGnM=
X-Received: by 2002:a05:6a00:2408:b0:643:aa2:4dd9 with SMTP id
 z8-20020a056a00240800b006430aa24dd9mr49908562pfh.7.1684309776997; Wed, 17 May
 2023 00:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230516033133.340936-1-kai.heng.feng@canonical.com>
 <IA1PR11MB61718EFB6DB1BF95CB1CEA5089799@IA1PR11MB6171.namprd11.prod.outlook.com>
 <SJ1PR11MB608384487F94EC485C91F47CFC799@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608384487F94EC485C91F47CFC799@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 17 May 2023 15:49:25 +0800
Message-ID: <CAAd53p56=CpWpPEOD2YdCneJX-XxO93MHMQHbLRB7VCYweW7SQ@mail.gmail.com>
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

On Wed, May 17, 2023 at 1:13=E2=80=AFAM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> >> [   13.875282] Hardware name: HP HP Z4 G5 Workstation Desktop PC/8962,
> > > BIOS U61 Ver. 01.01.15 04/19/2023
>
>
> >> When a DIMM slot is empty, the read value of mtr can be 0xffffffff, th=
erefore
>
> > Looked like a buggy BIOS/hw that didn't set the mtr register.
> >
> > 1. Did you print the mtr register whose value was 0xffffffff?
> > 2. Can you take a dmesg log with kernel "CONFIG_EDAC_DEBUG=3Dy" enabled=
?
> > 3. What was the CPU? Please take the output of "lscpu".
> > 4. Did you verify your patch that the issue was fixed on your systems?
>
> I wonder if BIOS is "hiding" some devices from the OS? The 0xffffffff ret=
urn is
> the standard PCI response for reading a non-existent register. But that d=
oesn't
> quite make sense with having a "dimm present" bit in the MTR register. If
> the register only exists if the DIMM is present, then there is no need fo=
r
> a "dimm present" bit.

I wonder if the "non-existent register" read is intended?

>
> Some "lspci" output may also be useful.

lspci can be found in [1]:

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217453

Kai-Heng

>
> -Tony
