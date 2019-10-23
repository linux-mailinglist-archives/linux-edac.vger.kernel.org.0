Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54CCBE1F23
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2019 17:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406591AbfJWPWd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Oct 2019 11:22:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390590AbfJWPWd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Oct 2019 11:22:33 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A9C2173B;
        Wed, 23 Oct 2019 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571844153;
        bh=xJ5Ug43nm7zSbxQ4Bnd58U6/uHIXTRGyKbwkCrb1hbE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lA2NM44oqKLQL6Py6n/5TEN6kzCCf0o2qZDzSPFWPRaxjnNhSP9gWyHdPy/3MI+ST
         0EmBiJA+WZHP5YdmXSzaZoOMQ2HgNII2FPPHLDGm4X99MiuyKlv9Vn7BCbB5HXgcQ3
         mqAq6As9iMEPgqhNWu+Gs8IRoUcOdR8T8sBxRQRw=
Received: by mail-qt1-f170.google.com with SMTP id o25so19459144qtr.5;
        Wed, 23 Oct 2019 08:22:32 -0700 (PDT)
X-Gm-Message-State: APjAAAVGzoaTsZdR3zBONji+Ry2XUn9eTNJUmJ99aSFg7GOh+MCerera
        G8dT7fcTT8YYx+hyW/yU7ESVszmrG+iZwY8YbA==
X-Google-Smtp-Source: APXvYqw/saQh1AzPPj9v3pcO4u41RTTvTh4j7xWPhNPzQFrE+1EfmtDNB6Fnbf7GdLX6CuuuefKnLoKY1LRcMSunzoU=
X-Received: by 2002:ac8:293b:: with SMTP id y56mr9877674qty.224.1571844152043;
 Wed, 23 Oct 2019 08:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR04MB6599EAA659A53B2331CB812586890@BY5PR04MB6599.namprd04.prod.outlook.com>
 <20190923161015.GI15355@zn.tnic> <e2b9cd68-abaa-bdcd-cc56-cca285272569@outlook.com>
 <41637032-a308-9a92-1b49-cb51af2580f8@outlook.com> <BY5PR04MB65996A0CEB37001C763B248C866C0@BY5PR04MB6599.namprd04.prod.outlook.com>
 <1ae9a840-d5b6-ccd6-8481-d43665b4411b@arm.com> <BY5PR04MB659953E22E846D0BF4384D0086690@BY5PR04MB6599.namprd04.prod.outlook.com>
 <70e31777-f4c0-fdd2-fcae-6589d355dd28@arm.com>
In-Reply-To: <70e31777-f4c0-fdd2-fcae-6589d355dd28@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 23 Oct 2019 10:22:20 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+m-3ojBWH9ni0NFJ08WxqQ784-Y1WcF_h19F=uUExrqw@mail.gmail.com>
Message-ID: <CAL_Jsq+m-3ojBWH9ni0NFJ08WxqQ784-Y1WcF_h19F=uUExrqw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: edac: arm-dmc520.txt
To:     James Morse <james.morse@arm.com>
Cc:     Lei Wang <leiwang_git@outlook.com>, Borislav Petkov <bp@alien8.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "hangl@microsoft.com" <hangl@microsoft.com>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        "ruizhao@microsoft.com" <ruizhao@microsoft.com>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "yuqing.shen@broadcom.com" <yuqing.shen@broadcom.com>,
        "ray.jui@broadcom.com" <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 23, 2019 at 8:22 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Lei,
>
> On 21/10/2019 18:36, Lei Wang wrote:
> >> It looks like your patches didn't make it to the mailing list:
> >> https://lore.kernel.org/r/BY5PR04MB6599EAA659A53B2331CB812586890@BY5PR04MB6599.namprd04.prod.outlook.com
> >>
> >> You can search on https://lore.kernel.org/linux-edac/, I can only see the replies from the
> >> people who received it directly.
> >>
> >> I can't see anything obvious in the headers that would cause it to get rejected. Did you
> >> get any bounces/errors from the list?
> >>
> >> Depending on how the DT folk work, this may be why you haven't had a response yet. Tools
> >> like patchwork will depend on the message reaching the list.
> >
> > Yes I got reject from
> >
> > linux-edac@vger.kernel.org
>
> > devicetree@vger.kernel.org
>
> This is very likely the reason the DT folk haven't seen this.

Yes, if it doesn't go to the DT list and into patchwork, then it goes
with the other 95K unread emails and maybe I see it.

Rob
