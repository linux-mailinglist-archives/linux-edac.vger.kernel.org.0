Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA6E13111C
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2020 12:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgAFLDb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 Jan 2020 06:03:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40891 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgAFLDb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 6 Jan 2020 06:03:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id w21so63517382otj.7;
        Mon, 06 Jan 2020 03:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6vdryAwpAtjdLmL+w82hzip04Zqpf7RG2w9DyYsoli4=;
        b=q4YbPMkfXd/I9FQeGyVxHlqjckdvE1tjIRfqafgAFdOgINud/OV2rTNYKuYY2RIcF5
         Te998iW27gIX+djVeqLQfZ56J9Lcio6zw0E/D0Sj/UXX3Nm79WZgH2mSXxRdxb8PIx6j
         MEl2Uct0/LoMaUGe4EqDrfufKVu2zwVScn1iMHz+V8RwFWdMryvKDijyIKjVdmlIYt5K
         4MhPX0SbSxSAkoauQMOF6D4yxI9OZTV9aXcHQ5ihMcQrW3bU4MqF/s5oqNQuDjI6tVP8
         cQnS2bzUbUvoxbMjxWQux/ZGFSqOjJgwBzuh5BlOXcVMt7gOUjAMyqsKj9NtDQ24Ypxv
         vJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6vdryAwpAtjdLmL+w82hzip04Zqpf7RG2w9DyYsoli4=;
        b=pm89ymOwJfJvfFxGR8Ml0/k/mOOj2ZplrQdXQM1d8RUjFFwo/w3aW4VkTFX1C7BBFy
         5iw3j1mxFD+puS1ORqVWR3xtZ+stBa9bZ8cv3GzYN8BA5BRR43Nm0Gv1oYR1gP+tOg40
         nGUCjJ5LICavSy4/mD9gEDHo9PTmuPGhPeeI+ozyszM/yxLGhV3Wr1P0aRAGC5moozUD
         oJQPTdCuDVQWAJA7zkb8Jl0+T6s+PL3IwRt7i6ZCzBxv1sTf2Ro20+6k0oqqyoHyOEO3
         +/zkrTsjrbs26m9rfSkhxlNb5UbWL9QmzMgP+43nyor7DRSztnCVUyqjvihDxGKDZHp/
         HClg==
X-Gm-Message-State: APjAAAWWGb7rZQfnkqm0/ORzic8an3poAvEczLhZAo8XvfeQimJVlkOH
        elYhqUXgqLSBU69JJm+hJW+ayVtW13q7A9J0LcI=
X-Google-Smtp-Source: APXvYqw9wUMjHkz2hw3pD8PhUwQ5RLqU5K/0A4FMvhStPMw80kAZ3AUyK0h+3wc9r20fi7Q5O0KQdUUAv0+WcRqMao8=
X-Received: by 2002:a05:6830:1e2d:: with SMTP id t13mr118894094otr.128.1578308610177;
 Mon, 06 Jan 2020 03:03:30 -0800 (PST)
MIME-Version: 1.0
References: <1576652618-27017-1-git-send-email-bupadhaya@marvell.com> <20200102180130.GG8345@zn.tnic>
In-Reply-To: <20200102180130.GG8345@zn.tnic>
From:   Bhaskar Upadhaya <bhaskar.upadhaya.linux@gmail.com>
Date:   Mon, 6 Jan 2020 16:33:19 +0530
Message-ID: <CAEYJA6oXTxTmJEji5_Hup2oB+GrgGnmSTiS-nNuzbNzGJ9VESA@mail.gmail.com>
Subject: Re: [RFC PATCH] apei/ghes: fix ghes_poll_func by registering in
 non-deferrable mode
To:     Borislav Petkov <bp@alien8.de>
Cc:     Bhaskar Upadhaya <bupadhaya@marvell.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, lenb@kernel.org, rafael@kernel.org,
        gkulkarni@marvell.com, rrichter@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 2, 2020 at 11:31 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Dec 17, 2019 at 11:03:38PM -0800, Bhaskar Upadhaya wrote:
> > Currently Linux register ghes_poll_func with TIMER_DEFERRABLE flag,
> > because of which it is serviced when the CPU eventually wakes up with a
> > subsequent non-deferrable timer and not at the configured polling interval.
> >
> > For polling mode, the polling interval configured by firmware should not
> > be exceeded as per ACPI_6_3 spec[refer Table 18-394],
>
> I see
>
> "Table 18-394 Hardware Error Notification Structure"
>
> where does it say that the interval should not be exceeded and what is
> going to happen if it gets exceeded?

Definition of poll interval as per spec (referred ACPI 6.3):
"Indicates the poll interval in milliseconds OSPM should use to
periodically check the error source for the presence of an error
condition."

This indicates OSPM should periodically check error source within poll
interval, but with timer being configured with TIMER_DEFERRABLE, timer
is not called within poll interval limit
>
> IOW, are you fixing something you're observing on some platform or
> you're reading the spec only?

We are observing an issue in our ThunderX2 platforms wherein
ghes_poll_func is not called within poll interval when timer is
configured with TIMER_DEFERRABLE flag(For NO_HZ kernel) and hence we
are losing the error records.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
