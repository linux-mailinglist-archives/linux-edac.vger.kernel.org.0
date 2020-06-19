Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119B71FFFF2
	for <lists+linux-edac@lfdr.de>; Fri, 19 Jun 2020 03:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgFSBzz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 18 Jun 2020 21:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbgFSBzz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 18 Jun 2020 21:55:55 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF388C06174E
        for <linux-edac@vger.kernel.org>; Thu, 18 Jun 2020 18:55:53 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id x189so9515802iof.9
        for <linux-edac@vger.kernel.org>; Thu, 18 Jun 2020 18:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Pl32oxUdBHkTR97CwMc5ZgAxNuKLw7Lk6JpqarL0HI=;
        b=pf90TgSN03OWLQs9hU7FbFwLLp99+3lo2t/0NkyNkMi/8c2akfiRLE/OgOLfF+tdFA
         7erFuV6W++m1ff4tBgbSzYIl0vzpaw10GZ97Wpr+5+AvliZJbRWC6M+t5Zu90HG7g2BN
         ulWN3Cv+ip8ZNnlukOGNbZflCWlDKwJAwqfMPqUk/D1ZrgD/EEfKDs5fw/yy0U/A+mm6
         PHvj388mbHWcVG6Hl/YMiwNbIYJdF9z9TI5Qi15/2+medU9FS+DOMWbMepc00HuyUM17
         s2soYv79XRm6w1bGWyUpwwVOYw+ivCOtaiPvleyvOtnt9MOfWwzx9Sxfmtpd2104ucO5
         HJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Pl32oxUdBHkTR97CwMc5ZgAxNuKLw7Lk6JpqarL0HI=;
        b=CWGtajT4ktWdzsQnaAIOBgAy4dodwGkqM+J8UcV8UH9mqGlRo+L1CBF+wTZQQo5llG
         uwj4S1wRyzVQ2X9oJ2shiMAjejNaonIKDJv1i2BS/7mMr0cPL43j2s1N9fWk8rf1uvyo
         6sOVT+zPVtCk7XHh0AhP7wZXYIpCtVJ/oTfvCZMlSbC7bhkI91nYQIuBMX5HJjon4Tu2
         JR5QjVmysGxe+LypzUi5TBCNTL6WH3zhifgJcDUZv5apR+XAFSk6XYWZ2Lwe9zCeZYFB
         pKrZ0YyS4Mm8Demz/b8TvceAkFOIB1jZgTgBNL8Pue2IBR8RDZOnEsLeucBEfU/8UGRT
         nwXA==
X-Gm-Message-State: AOAM531IP7K1RW6udGKx/nKSKB/AAvX775rtN7KblDJUVbk5opo0WrMx
        boWPHvF28D+dTvcx/eJXzo4cs5TN58M7Dlx7SmjOptCd
X-Google-Smtp-Source: ABdhPJzUZCKNl8Se5pyRezuR0imMATFR8q5pNPBj0ZkvYWAJMQSurTFFUd7S2vMS5k0VmUJQLeXiyS+BgYBykaZh2eI=
X-Received: by 2002:a02:c802:: with SMTP id p2mr1595481jao.111.1592531753183;
 Thu, 18 Jun 2020 18:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAKkunMbNWppx_i6xSdDHLseA2QQmGJqj_crY=NF-GZML5np4Vw@mail.gmail.com>
 <20200618175646.GD27951@zn.tnic>
In-Reply-To: <20200618175646.GD27951@zn.tnic>
From:   Anders Andersson <pipatron@gmail.com>
Date:   Fri, 19 Jun 2020 03:55:16 +0200
Message-ID: <CAKkunMaXyw+U-izfgXRuhN1tafjXksw_6rsMB82xv=zseFgkqA@mail.gmail.com>
Subject: Re: User question about memory scrubbing
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 18, 2020 at 7:56 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jun 18, 2020 at 06:49:45PM +0200, Anders Andersson wrote:
> > Hi! I realize that this is more of a developer-to-developer list, but
> > I'm a hobbyist who recently bought my first system with ECC RAM
> > (Opteron 6386 SE) and I can't get memory scrubbing to work. It's hard
> > to find people who know anything about it.
> >
> > Preliminary research led me to the EDAC documentation on
> > https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-devices-edac
> > and in particular the "sdram_scrub_rate" file, but had no luck
> > manipulating it.
>
> Oh, you're manipulating it alright but there's a bug in reporting it.
> Wanna test a patch?

Wow, nice to see that I'm not crazy, and thanks for the quick fix! I
saw the patch and I will try it out after I've re-learnt how to build
a kernel again. It's been well over 10 years since I last had to...

// Anders
