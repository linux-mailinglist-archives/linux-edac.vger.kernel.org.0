Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10DB9CE273
	for <lists+linux-edac@lfdr.de>; Mon,  7 Oct 2019 14:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfJGM6m (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Oct 2019 08:58:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32960 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfJGM6m (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Oct 2019 08:58:42 -0400
Received: by mail-io1-f66.google.com with SMTP id z19so28365000ior.0
        for <linux-edac@vger.kernel.org>; Mon, 07 Oct 2019 05:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8l3nHQoo5KrfosBE5GsvyWlZH1YvUhLxkA/knFW9LIQ=;
        b=fNFa1NkrMMJSC4XMTn00w3yIVVDgTQfPmWantNBylRIOF1l4OoKLBXc3ivo1H7pnm5
         EM96CAUREiO1ppJtFnKG0t4qv/fVSza86VFf75eQDxccxJUZS7Xw3lLlA/CAvfM8jNx+
         Ctif97iHh4AqsHn9eQ9AGJ/gG3eybEF22uK3e2n+VWCGgxKr4Bb/rdFmxO5Waxu0ER4+
         extBRxmeD+yTnLWYh2cPWRrVHjzk9gh6g1deQeu6kwTk9oN7rP3iCm+OHIIAsMhIKOdU
         lil6pBgm/6rcmHIulfff7NWb6DP0/xAnuJMBNCeClNxPbzeoja28FQGvnom4eMvkhswC
         GJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8l3nHQoo5KrfosBE5GsvyWlZH1YvUhLxkA/knFW9LIQ=;
        b=Wi6cs3bkuH/qzI8zh4pbSiPPP4BrsykGpW28pFNRlOEr2kbAtobuaIzugmwG29XYP6
         WcsB9cArOvl6rFla2DGnBCRljMXyUtOtZAnnktshwFlcrjMDS7q6gd+B4RKPsabatmqT
         PXhaokzDaqWvqPVBMG/4KECbtXrbL9ZgKmL65OG9AGhONoUMUQBOmr9MrGAn/vmcnApO
         HxiweSh/cJLgbHEeE3sv/vJ5OiJOOL2J3JblRlRH4klsjiRf6SPZSll6CeCbTPu5MLUK
         3z7Cokb/Jq2pQbjW6E8KMJDh3bVfTtqdpAjouHy+0WHANH1LQPIiPn+GXfOziA5bBM9g
         QuZA==
X-Gm-Message-State: APjAAAWlYF6wIy9wCt395k+izc3kC6PoPNIOywDsxaWg9/i/xpPSDE1F
        vfAOXODawpsozOx7UwyauJC0hgzC/CcE3Fg+QLPb1A==
X-Google-Smtp-Source: APXvYqxb8VH37A0eahxLLr5P7tOFLpzP1eBI0QOK9STvKO4y9MBw+DtlveIyopBRzIPdKBvQHivEZFXlyWI20kux8fw=
X-Received: by 2002:a02:c8cd:: with SMTP id q13mr26582927jao.133.1570453121052;
 Mon, 07 Oct 2019 05:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAEVokG7TeAbmkhaxiTpsxhv1pQzqRpU=mR8gVjixb5kXo3s2Eg@mail.gmail.com>
 <20190924092644.GC19317@zn.tnic> <CAEVokG7UmudOALmeTBq2NgFSiZyGq_6b58nHt2UUHAM2Mzbw+Q@mail.gmail.com>
 <20191007071502.GA24289@zn.tnic>
In-Reply-To: <20191007071502.GA24289@zn.tnic>
From:   Jeff God <jfgaudreault@gmail.com>
Date:   Mon, 7 Oct 2019 08:58:30 -0400
Message-ID: <CAEVokG51DtL1g+9YFK6RE=3m-wtjV1VN=vV56b5-3=K21=Jmrw@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 7 Oct 2019 at 03:16, Borislav Petkov <bp@alien8.de> wrote:
>
> Try this as root (the first command is cd-ing into the default debugfs
> mountpoint - check whether that is the case on your system first).
>
> # cd /sys/kernel/debug/mce-inject/
> # echo 10 > /sys/devices/system/machinecheck/machinecheck0/check_interval
> # echo 0x9c7d410092080813 > status; echo 0x000000006d3d483b > addr; echo 2 > cpu; echo hw > flags; echo 4 > bank
>
> If you have this in your dmesg:
>
> [    1.420991] RAS: Correctable Errors collector initialized.
>
> then you need to boot with "ras=cec_disable" first.

Yes, I had to add ras=cec_disable in my case based on dmesg, but after
that the command above still did not output anything to dmesg or any
error.

> > but it does not seem EDAC ever report any ce (or ue) ecc error even
> > when they may be happening and corrected in background.
>
> What does that mean?
>
> You are getting ECCs or you simply want to test whether the ECC
> reporting works on your machine?
>

I want to test that the ECC reporting is working on my machine (so
that when real errors will happen one day I will get notified)

The method I described previously to generate errors by overclocking
memory was my initial method to generate real errors, which proved to
work well on another system with a previous generation AMD Ryzen 2700x
and similar motherboard and same memory, but on this system it does
not report any error, although turning off ECC in the bios showed that
memory corruption is happening fairly quickly in this case, hence the
conclusion that error reporting was probably not working but the
underlying memory error correction system may be working.

Jean-Frederic
