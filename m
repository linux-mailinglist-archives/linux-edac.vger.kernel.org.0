Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43772381829
	for <lists+linux-edac@lfdr.de>; Sat, 15 May 2021 13:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhEOLMO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 15 May 2021 07:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhEOLMO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 15 May 2021 07:12:14 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49C0C061573
        for <linux-edac@vger.kernel.org>; Sat, 15 May 2021 04:11:00 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u20so1517470ljo.4
        for <linux-edac@vger.kernel.org>; Sat, 15 May 2021 04:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8Jej9TCfEzTxi3oE1Q7czgOSXyu246mYIzlFyO/Ss/M=;
        b=aOg42vDLh4f3psOAim4tY+2DAuoqiO4x3EEUPC1DyPwCQULjPjDjFseJCQZPe5vTbA
         6FYH4kzEtQD8XGGZR7Vzyf6ILN9ovtM/qIVfQzsI2nTvS1iPJaw05S+11Ryooz30yEIF
         I3ZokIidKAs0Fmz4urRlpE5l6df+VzZw5D0O0LypZgfsNbiUH256PvfTN3Vqd3F+SNZd
         vctjRvGnNB1fvqNF57e9uMERhT5AvdBdxpZqouoBfDWp8AN3EUc35JbMkyioLm1Z2Qaw
         07aUwZgJf0o2cmVutkHpTHy8qSlDfFbtre9p4z3xo86YDV8qwfzUfCt2hFnISnL/XBGV
         Il+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=8Jej9TCfEzTxi3oE1Q7czgOSXyu246mYIzlFyO/Ss/M=;
        b=hgwHi13T8D9YfATcQnW8Fw6+XC2Ieh6nrACt878oCyHwnbRMmX/o2bj0lwDa5dj98B
         1/0wDyvAKwKbn2Jgctzr3yvJKFxMAa2yvfDFcOdxdJuArBrA5IO9bIC93rZOK9tH75Sl
         wz58tK/hxOyx+BeK0kKeyKPRk9a6TQTcZQVz0DrxwE1PkMOucnWyCCdb/JlpMzyxC4lA
         zYF71jY6YJHaDhreGViZxasI2TmRvTTMAzKhG6/EkNmRyZoH2qQl7pn/PF6fyPe6Jav4
         rWTBuSq3YkCXoLmJCnAQUTxuAVoez8zr3MZTM4xIY3eCACvZHBkBBRnvI1zdKbdPlu1g
         i8ow==
X-Gm-Message-State: AOAM533a7L2kqXoivdn/iov8W2aL5cX2uCicv8C7KDOZBAplWgMWhbP+
        2YNoMMQzYGzHo1BqJkOdwsp8x0gGwEqmwgNJgRqjbcY+
X-Google-Smtp-Source: ABdhPJzZgdN4I8cpwQvemh9UMKuCpXSj/M4Vn420yqrlJvy0fvvnlqFC6GbIhj3CvPQr2UDcjHbKnsFiLkJjMRiEg50=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr43646841ljg.74.1621077058988;
 Sat, 15 May 2021 04:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAC0EBY-QL5LP+POpyjjt-8rc7d5r2YC+2gzf-SShrJ6DQoyWqw@mail.gmail.com>
 <CAC0EBY8piMhd=wTKb94_cEP9FHWax_79V+MTt4_cY7jZYdoRkg@mail.gmail.com>
In-Reply-To: <CAC0EBY8piMhd=wTKb94_cEP9FHWax_79V+MTt4_cY7jZYdoRkg@mail.gmail.com>
From:   Rick Moritz <rahvin@gmail.com>
Date:   Sat, 15 May 2021 13:10:48 +0200
Message-ID: <CAC0EBY_u_cYEZPfHUq04f5J1edSk4WUiGYXmy=TyzsGjQT9G8A@mail.gmail.com>
Subject: Re: ie31200_edac missing PCI ID for i3-4370
To:     linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi List, Hi Jason, Hi Paul,

Sorry for reviving this relatively old thread, but it brought back
memories from 2016, when I tried to add the Skylake i3's (PCI-ID
190f).

I've been running a modified kernel since then, with no issues (but no
proof that any error reporting is being done).

Output from ecc-utils is merely:

edac-util -v
mc0: 0 Uncorrected Errors with no DIMM info
mc0: 0 Corrected Errors with no DIMM info
edac-util: No errors to report.

without any of the DIMM-information I would expect..
The /sys tree for edac also contains Unknown for e.g. dimm_edac_node,
which isn't quite promising either.
The doc should be here:
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/des=
ktop-6th-gen-core-family-datasheet-vol-2.pdf
Comparing the contents of the DID register does show a different
layout, something to keep in mind for the Haswell i3's as well.

Also, I'm not sure how this change will behave on same-generation
desktop i5s/i7s - they may just report nothing. Even the i3s may not
report any EDAC, depending how deep the ECC implementation really
goes.

Finally: did the original thread ever end in a kernel patch? I
couldn't find anything that looks related.

As I am back in kernel compiling, I will try and get my 6th gen i3 to
work - but I guess first I will need to dive into the code and data
sheet some more. I'd be glad for any pointers.

I would really like to hear back from Paul, how far he managed to get
with Haswell.

Cheers,


Rick


Full quote of last post in thread for reference:

On 2/9/21 10:27 PM, Jason Baron wrote:
>
>
> On 2/9/21 6:58 PM, Paul Marks wrote:
>> On Tue, Feb 9, 2021 at 2:25 PM Jason Baron <jbaron@akamai.com> wrote:
>>> On 2/4/21 6:22 PM, Paul Marks wrote:
>>>> On Thu, Feb 4, 2021 at 2:59 PM Jason Baron <jbaron@akamai.com> wrote:
>>>>> On 1/31/21 7:07 PM, Paul Marks wrote:
>>>>>> I have an ASRock C226M WS with an i3-4370 CPU.
>>>>>>
>>>>>> # lspci -vnn
>>>>>> 00:00.0 Host bridge [0600]: Intel Corporation 4th Gen Core Processor
>>>>>> =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=
=82 =C3=82 =C3=82  DRAM Controller [8086:0c00] (rev 06)
>>>>>> =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82  Subsystem: =
ASRock Incorporation 4th Gen Core Processor
>>>>>> =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=
=82 =C3=82 =C3=82  DRAM Controller [1849:0c00]
>>>>>> =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82  Flags: bus =
master, fast devsel, latency 0
>>>>>> =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82  Capabilitie=
s: [e0] Vendor Specific Information: Len=3D0c <?>
>>>>>> =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82  Kernel driv=
er in use: hsw_uncore
>>>>>>
>>>>>> But edac-util doesn't work:
>>>>>>
>>>>>> # edac-util -v
>>>>>> edac-util: Fatal: Unable to get EDAC data: Unable to find EDAC data =
in sysfs
>>>>>>
>>>>>> I tried this ham-fisted patch:
>>>>>>
>>>>>> # diff -u ./drivers/edac/ie31200_edac.c{.old,}
>>>>>> --- ./drivers/edac/ie31200_edac.c.old
>>>>>> +++ ./drivers/edac/ie31200_edac.c
>>>>>> @@ -58,7 +58,7 @@
>>>>>> =C3=82  #define PCI_DEVICE_ID_INTEL_IE31200_HB_3 0x0150
>>>>>> =C3=82  #define PCI_DEVICE_ID_INTEL_IE31200_HB_4 0x0158
>>>>>> =C3=82  #define PCI_DEVICE_ID_INTEL_IE31200_HB_5 0x015c
>>>>>> -#define PCI_DEVICE_ID_INTEL_IE31200_HB_6 0x0c04
>>>>>> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_6 0x0c00
>>>>>> =C3=82  #define PCI_DEVICE_ID_INTEL_IE31200_HB_7 0x0c08
>>>>>> =C3=82  #define PCI_DEVICE_ID_INTEL_IE31200_HB_8 0x1918
>>>>>> =C3=82  #define PCI_DEVICE_ID_INTEL_IE31200_HB_9 0x5918
>>>>> just curious why you removed here and didn't just add?
>>>> This is not a serious patch, just a one-liner to demonstrate the probl=
em.
>>> Ok. Any chance you can find the datasheet that shows that this
>>> driver is using the appropriate registers for this hw? I didn't
>>> find it quickly looking...
>>>
>> I wouldn't know where to begin.=C3=82  Do you have an example of a simil=
ar
>> datasheet from one of the known-good devices?
>>
>> I left "memtester" running on this machine, because it might increase
>> the odds of generating an ECC error someday.
> Hi Paul,
>
> I have a list of them at the top of:
> drivers/edac/ie31200_edac.c
>
> According to the following intel link it looks
> like '0xc[0-f]' is valid (page 52):

Sorry meant to write that as: '0x0c0[0-f]'.


> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/x=
eon-e3-1200v3-vol-2-datasheet.pdf
>
> So I'm fine with this patch (assuming it just
> becomes an addition).
>
> Thanks,
>
> -Jason
>
