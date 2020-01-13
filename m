Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECAA138F9D
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2020 11:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgAMKwG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Jan 2020 05:52:06 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33317 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgAMKwG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Jan 2020 05:52:06 -0500
Received: by mail-oi1-f195.google.com with SMTP id v140so7827422oie.0;
        Mon, 13 Jan 2020 02:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtPM0qNpCXM1Rp0ETmaEt0V+zDCKJAyqKnvcFDnN5TI=;
        b=WA4RR2py+X17VEccHsq0Sdywm2W6ngeIRGqz90eIxFxnLoNNH2GhBqHz0n9S118gJc
         zskt81YTcUo+d9Fj2CTm1kffpU2UPoJYCXCyE201l58tLyLZDA9t45UdwDazYqbtXJIb
         sVrU7nBIHEMf7NpTfzR7XympmiEA4cwYdQucqsWCqzv2XVzc22hDeYUx1LlmuMwGVbhn
         0OBuGyTOFN+Du9SJaKcdfC881dPjwoA7wOpuzgKRwoG+YPKhq4Av0bf/Kezco38fT43W
         Oh1p34UU5m67PG1MjLvgRpZ4IjJa6U5LsMHtvH5AgNlN3Rcaq6kUzTxxH1M+bQpaM9pH
         4IwA==
X-Gm-Message-State: APjAAAX1zJaAvdkl4srzVC7XPnEh1fsq0UoNOxpgGfTGhwg7R+UHv0fN
        3jaIVuxVpQmh3cLF4ckbwkajK45/rR9usETeSD4=
X-Google-Smtp-Source: APXvYqwbPBJ7mO31GdY19gP+AB/5p+E2X/W43tAwX6BnwDbHMCtzOVfiGXE9nXaiCBE06uLBIrvcFyfeOTJNQ6C/roU=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr12916572oig.103.1578912725769;
 Mon, 13 Jan 2020 02:52:05 -0800 (PST)
MIME-Version: 1.0
References: <1578503858-27853-1-git-send-email-bupadhaya@marvell.com> <20200109095026.GA5603@zn.tnic>
In-Reply-To: <20200109095026.GA5603@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Jan 2020 11:51:54 +0100
Message-ID: <CAJZ5v0gohOwnGqMk86Zyqxn11fxukXifSe=T08n7vrvv5Q4QNw@mail.gmail.com>
Subject: Re: [PATCH V2] apei/ghes: fix ghes_poll_func by registering in
 non-deferrable mode
To:     Borislav Petkov <bp@alien8.de>
Cc:     Bhaskar Upadhaya <bupadhaya@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, gkulkarni@marvell.com,
        Robert Richter <rrichter@marvell.com>,
        bhaskar.upadhaya.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 9, 2020 at 10:50 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jan 08, 2020 at 09:17:38AM -0800, Bhaskar Upadhaya wrote:
> > Currently Linux register ghes_poll_func with TIMER_DEFERRABLE flag,
> > because of which it is serviced when the CPU eventually wakes up with a
> > subsequent non-deferrable timer and not at the configured polling interval.
> >
> > For polling mode, the polling interval configured by firmware should not
> > be exceeded as per ACPI_6_3 spec[refer Table 18-394], So Timer need to
> > be configured in non-deferrable mode by removing TIMER_DEFERRABLE flag.
> > With NO_HZ enabled and timer callback being configured in non-deferrable
> > mode, timer callback will get called exactly after polling interval.
> >
> > Definition of poll interval as per spec (referred ACPI 6.3):
> > "Indicates the poll interval in milliseconds OSPM should use to
> > periodically check the error source for the presence of an error
> > condition"
> >
> > We are observing an issue in our ThunderX2 platforms wherein
> > ghes_poll_func is not called within poll interval when timer is
> > configured with TIMER_DEFERRABLE flag(For NO_HZ kernel) and hence
> > we are losing the error records.
> >
> > Impact of removing TIMER_DEFFERABLE flag
> > - With NO_HZ enabled, additional timer ticks and unnecessary wakeups of
> >  the cpu happens exactly after polling interval.
> >
> > - If polling interval is too small than polling function will be called
> >  too frequently which may stall the cpu.
>
> If that becomes a problem, the polling interval setting should be fixed
> to filter too small values.
>
> Anyway, I went and streamlined your commit message:
>
>     apei/ghes: Do not delay GHES polling
>
>     Currently, the ghes_poll_func() timer callback is registered with the
>     TIMER_DEFERRABLE flag. Thus, it is run when the CPU eventually wakes
>     up together with a subsequent non-deferrable timer and not at the precisely
>     configured polling interval.
>
>     For polling mode, the polling interval configured by firmware should not
>     be exceeded according to the ACPI spec 6.3, Table 18-394. The definition
>     of the polling interval is:
>
>     "Indicates the poll interval in milliseconds OSPM should use to
>     periodically check the error source for the presence of an error
>     condition."
>
>     If this interval is extended due to the timer callback deferring, error
>     records can get lost. Which we are observing on our ThunderX2 platforms.
>
>     Therefore, remove the TIMER_DEFERRABLE flag so that the timer callback
>     executes at the precise interval.
>
> and made it more readable, hopefully.
>
> Rafael, pls fixup when applying.

Done.

> With that:
>
> Acked-by: Borislav Petkov <bp@suse.de>

Thanks!
