Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA2A315B23
	for <lists+linux-edac@lfdr.de>; Wed, 10 Feb 2021 01:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhBJA1i (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Feb 2021 19:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbhBIX7b (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Feb 2021 18:59:31 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A53FC061786
        for <linux-edac@vger.kernel.org>; Tue,  9 Feb 2021 15:58:15 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jj19so658437ejc.4
        for <linux-edac@vger.kernel.org>; Tue, 09 Feb 2021 15:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pmarks-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TP+Yr/OSTPmZ5/aydHhG5oyKcrmyZzZSL/M2vBWtA0k=;
        b=wjgWE9PfjoxdTCurFc6OBV4UFff11EAXWeiMqoX5rqo3e/Xl0LHp77Vm7p532y5ZYt
         LttEZJOBAAcsyUPKWD3Qy4FStD3nIYhnuuyL1UkA5FGVWhDO1nfsaJ/3uaQSH+W9R0fz
         Dz8JXW7xfqsI1g7iMugxnUhMnPdG6to4VW1IgfLKn5r/0FncUSaBAanuH8A2fAJna1kf
         xQqV62okn13gp8JhhURHj9b1YNZtP/xB96fF04Y6eJxT2fFGzmClZlS2U9xrfmJK0kHN
         iT3OuHgAtktcAlHfbmvVngwKfdgzcZVWQk/C4Fg0X9w/2f74VdpiLtvDRIuTu/eu7jbY
         WWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TP+Yr/OSTPmZ5/aydHhG5oyKcrmyZzZSL/M2vBWtA0k=;
        b=GyoApqmxvKLyGxt/tAb0EsDkcqXbJ/9/9qlx9DsS/9JmEoRU5RhyESsUasKs7giIJR
         o1wmrs1lkADA8dkD/+Qq94kQDbiyUv3LxXQaAaYCFOgDKFamm/F7t0+/ud4fHQj7JV5E
         +tKR0r7HRzRLXBfW4OFjxI5BKtL7lZn0BlqpPvzTIaiHdEuKrtfOqu1BXHilpZiI6L90
         9PpFHF951mFyQk75VbxCp1dPAYs1S2M69wDc4RZ/OLgSX8/ImuOJu1gzv31XdJ06+olh
         mBYQsFf9Wh/sSvIEzMQWw2Q7Q/kkKl96OFuga/xErTnhf1+pf6gE1wMqKf2mVSc26e6Z
         Oj6Q==
X-Gm-Message-State: AOAM530vD95L0nyG6OvRpdais1ovr+V/vT0XOclJqgzgow9k74QLBc6i
        p7Ye06SIKednxhU5RsPi9v0nIE14OkJjO1hOc1FMXtsp
X-Google-Smtp-Source: ABdhPJwHXZ3GHbGocWaFII2+N9LM9Lh8J7v6/P1/vfkH9LvCa3NH5mJc+NhPL4O8G4BwjcGktQ0JePzocMsrH54G0tw=
X-Received: by 2002:a17:906:8292:: with SMTP id h18mr224875ejx.342.1612915094265;
 Tue, 09 Feb 2021 15:58:14 -0800 (PST)
MIME-Version: 1.0
References: <CAHq9+ShGiB_H6-E=L398zYR=ja16r2OuvJZfU4KLof=segyJbw@mail.gmail.com>
 <ecb895bf-f384-e5e6-d434-d3a8e06eaf47@akamai.com> <CAHq9+Si+oyG=8j6xs-a=Jq+8vxU3eHzNOzbA9JXonsFvHd=O=A@mail.gmail.com>
 <77c3f46c-3519-d791-7bfe-97186d6893bb@akamai.com>
In-Reply-To: <77c3f46c-3519-d791-7bfe-97186d6893bb@akamai.com>
From:   Paul Marks <paul@pmarks.net>
Date:   Tue, 9 Feb 2021 15:58:03 -0800
Message-ID: <CAHq9+ShvTowrZusjxFV+yGzM=gCmG_mFJAsKwaHQ=qi_OknKCA@mail.gmail.com>
Subject: Re: ie31200_edac missing PCI ID for i3-4370
To:     Jason Baron <jbaron@akamai.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Feb 9, 2021 at 2:25 PM Jason Baron <jbaron@akamai.com> wrote:
>
> On 2/4/21 6:22 PM, Paul Marks wrote:
> > On Thu, Feb 4, 2021 at 2:59 PM Jason Baron <jbaron@akamai.com> wrote:
> >>
> >> On 1/31/21 7:07 PM, Paul Marks wrote:
> >>> I have an ASRock C226M WS with an i3-4370 CPU.
> >>>
> >>> # lspci -vnn
> >>> 00:00.0 Host bridge [0600]: Intel Corporation 4th Gen Core Processor
> >>>             DRAM Controller [8086:0c00] (rev 06)
> >>>         Subsystem: ASRock Incorporation 4th Gen Core Processor
> >>>             DRAM Controller [1849:0c00]
> >>>         Flags: bus master, fast devsel, latency 0
> >>>         Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> >>>         Kernel driver in use: hsw_uncore
> >>>
> >>> But edac-util doesn't work:
> >>>
> >>> # edac-util -v
> >>> edac-util: Fatal: Unable to get EDAC data: Unable to find EDAC data in sysfs
> >>>
> >>> I tried this ham-fisted patch:
> >>>
> >>> # diff -u ./drivers/edac/ie31200_edac.c{.old,}
> >>> --- ./drivers/edac/ie31200_edac.c.old
> >>> +++ ./drivers/edac/ie31200_edac.c
> >>> @@ -58,7 +58,7 @@
> >>>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_3 0x0150
> >>>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_4 0x0158
> >>>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_5 0x015c
> >>> -#define PCI_DEVICE_ID_INTEL_IE31200_HB_6 0x0c04
> >>> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_6 0x0c00
> >>>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_7 0x0c08
> >>>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_8 0x1918
> >>>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_9 0x5918
> >>
> >> just curious why you removed here and didn't just add?
> >
> > This is not a serious patch, just a one-liner to demonstrate the problem.
>
> Ok. Any chance you can find the datasheet that shows that this
> driver is using the appropriate registers for this hw? I didn't
> find it quickly looking...
>

I wouldn't know where to begin.  Do you have an example of a similar
datasheet from one of the known-good devices?

I left "memtester" running on this machine, because it might increase
the odds of generating an ECC error someday.
