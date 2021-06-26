Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436CD3B4FBC
	for <lists+linux-edac@lfdr.de>; Sat, 26 Jun 2021 19:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhFZRYs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 26 Jun 2021 13:24:48 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:60104 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFZRYs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 26 Jun 2021 13:24:48 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0280192009C; Sat, 26 Jun 2021 19:22:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E873B92009B;
        Sat, 26 Jun 2021 19:22:23 +0200 (CEST)
Date:   Sat, 26 Jun 2021 19:22:23 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arch: mips: remove dead references
In-Reply-To: <CAAdtpL6CMAbBPJr3La31Y3AYY48TjLZhDHjKWjUJxXdBS--Xmw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2106261919300.37803@angie.orcam.me.uk>
References: <20210625110419.24503-1-lukas.bulwahn@gmail.com> <20210625110419.24503-4-lukas.bulwahn@gmail.com> <CAAdtpL6CMAbBPJr3La31Y3AYY48TjLZhDHjKWjUJxXdBS--Xmw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, 26 Jun 2021, Philippe Mathieu-Daudé wrote:

> >   http://www.computer-refuge.org/classiccmp/ftp.digital.com/pub/DEC/TriAdd/
> 
> https://web.archive.org/web/20050205114151/ftp.digital.com/pub/DEC/TriAdd/

 I suggest: <ftp://ftp.hp.com/pub/alphaserver/archive/triadd/> as the 
canonical reference nowadays.  If that goes offline sometime, we can think 
of an alternative.

  Maciej
