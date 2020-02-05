Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA8515381B
	for <lists+linux-edac@lfdr.de>; Wed,  5 Feb 2020 19:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgBESZU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Feb 2020 13:25:20 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:40843 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgBESZU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 Feb 2020 13:25:20 -0500
Received: by mail-qk1-f169.google.com with SMTP id b7so2819958qkl.7
        for <linux-edac@vger.kernel.org>; Wed, 05 Feb 2020 10:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUi8K68+afFQbHz8BrUBvZ94n/k3mtbVv15EiKvcYsA=;
        b=aRtY42pYqP7shJ4zusTVGkuPNtNuOfTR1jMym5dFFUczEwrevJ3vSr5BwhvH8PxR79
         MF4IiAehRFV0h/y/BoDMRjFhnz46p6qCYMlxVWsQTHoEaqtX8RnnoiMGeyVe9IvzE8ej
         qLq+7QpiWJZhccBfW8OM1g3IpDPRFbE6JFb+OSxghoKSuBGI7qtUSsWHZIxFEc6oEXiv
         5+pH01wLYpZd7+pBR2tZcmqL2Vcht063sZNOGSHoWEAXRECDcO+x4AoXwqhry4IKjZHY
         4GGrCuyrLfKQSEH6xo3fBABpWvB8JCxegoVq1oOoYE1G85tfwP49buO/mp3wl0OK5feS
         aRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUi8K68+afFQbHz8BrUBvZ94n/k3mtbVv15EiKvcYsA=;
        b=N3CosVN90N8ZAB+yFp9NsUu53hiCxtIsjqF2bl5jxpyE3WLfkxs6umbEgibsQo8nMS
         zIFj6aXJTMlJniwSrGpRRnZMtOihrXGfDdE97l1LgiJJd+I/N6/3S/qPAxpRBE8mgnjk
         In7sHTFAzG1L9RRKja+l9SmAM3RfTVoZeNkM2w0gi1iY1wBzXgDZqdu6J/xGbm42MZyB
         tDGPbUq1tkNDxqZbu9JpsvhZZqMCOSSeIYnHA4kz2MG0SbGVhOXZqaprNa9jdaSSYbvb
         Qf5oTDE0nWceAZLYF9XoBhYMHzwBX7dQAFhf3Ilvwdy3S+qb97Sq6qrwVD7h7AhEoKdE
         t1OQ==
X-Gm-Message-State: APjAAAUrO4MhUtohDA0bYn6OaZ8gmJCcQYfRS8Wjzqhk/Qsil78DQeCI
        hoYcZLbbIZWkW1K/go9/DxJJBb29FMnG+hvIbLEm/w==
X-Google-Smtp-Source: APXvYqyVRtI7Ifw9JtnoO/DXgNcM7jgMETFSmPirVruMJZZIxGJs8ROydZrRloaJ9dP+EsVHo6Lu1ZaUHgau3VMhV9E=
X-Received: by 2002:ae9:efc5:: with SMTP id d188mr34711939qkg.178.1580927117945;
 Wed, 05 Feb 2020 10:25:17 -0800 (PST)
MIME-Version: 1.0
References: <CACNqQuQNsVyqxW2yq_W=EN2f0q7oP-Fkfe9vXWV4wMznZ093jA@mail.gmail.com>
In-Reply-To: <CACNqQuQNsVyqxW2yq_W=EN2f0q7oP-Fkfe9vXWV4wMznZ093jA@mail.gmail.com>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Wed, 5 Feb 2020 10:25:07 -0800
Message-ID: <CA+8MBb+R4V-uesUbsy=5y2FOxHV11k6e=G2uFQe0yV13wCQ3RQ@mail.gmail.com>
Subject: Re: Qumulo: a question about UECC detection from the ie31200_edac ko
To:     Dan Pehush <dpehush@qumulo.com>
Cc:     Linux Edac Mailing List <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 3, 2020 at 5:27 PM Dan Pehush <dpehush@qumulo.com> wrote:
>
> Hi All,
>
>    My name is Daniel Pehush, I work on the hardware team at an
> enterprise data storage company called Qumulo Inc. We want to be able
> to have our server systems kernel PANIC on the occurrence of a UECC
> error. A UECC should be treated as an interrupt. We were working with
> Intel to get resolution for this desired behavior, and they have
> directed us ask for guidance from the developers of this kernel
> module. Our current configuration is the following ...

I haven't done much with the E3 systems.  Do you know if you
get CMCI interrupts for corrected errors?  If you do, then it is
likely that you'd also get a CMCI for an uncorrected error too.
[Worst acronym ever ... Corrected Machine Check Interrupt, can
happen for uncorrected errors. Totally separate from the "Machine
Check"  INT#18].

Clues to check:
1) Is MCG_CAP bit 10 (MCG_CMCI) set?
2) If so, use rdmsr(8) to look at each MCi_CTL2 (0x280, 0x281, ... 0x280+nbanks)
to see if bit 30 (CMCI_EN) is set.

If that's the case, then you may just need to modify your EDAC driver
to panic if is sees MCi_STATUS.UC == 1

Note that doesn't give you complete containment of the error. Whatever
read the uncorrected data is going to use it until the CMCI is delivered
and your driver calls panic.  If this is an application, or kernel code with
interrupts enabled, then the window is tiny. If the kernel accessed with
interrupts off, then a lot may happen to that bad data before the plug is
pulled.

-Tony
