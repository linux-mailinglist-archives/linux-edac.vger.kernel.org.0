Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637603B553D
	for <lists+linux-edac@lfdr.de>; Sun, 27 Jun 2021 23:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhF0VXa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 27 Jun 2021 17:23:30 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:38804 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231636AbhF0VX3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Sun, 27 Jun 2021 17:23:29 -0400
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Jun 2021 17:23:29 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 4A67C18028B6B;
        Sun, 27 Jun 2021 21:12:20 +0000 (UTC)
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 0D552182CED2A;
        Sun, 27 Jun 2021 21:12:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id D3A45315D78;
        Sun, 27 Jun 2021 21:12:15 +0000 (UTC)
Message-ID: <4c3900ab7d9493e3ce516d3f03ed1de17c1fcb10.camel@perches.com>
Subject: Re: [PATCH v2 0/3] Remove dead linux-mips.org references
From:   Joe Perches <joe@perches.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kurt Martin <kmartin@wavecomp.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Willy Tarreau <w@1wt.eu>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2106251722470.37803@angie.orcam.me.uk>
References: <20210625110419.24503-1-lukas.bulwahn@gmail.com>
         <alpine.DEB.2.21.2106251722470.37803@angie.orcam.me.uk>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Date:   Sat, 26 Jun 2021 16:45:02 -0700
User-Agent: Evolution 3.40.0-1 
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.45
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: D3A45315D78
X-Stat-Signature: 51ppnfim499fwps5bzrtzxauy98arc7f
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19Z0wJIIGI4YrqBWx6kzmLHiegdDfERt2s=
X-HE-Tag: 1624828335-632179
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, 2021-06-25 at 17:49 +0200, Maciej W. Rozycki wrote:
> [Adding Ralf and Kurt to the list of recipients.]
> 
> On Fri, 25 Jun 2021, Lukas Bulwahn wrote:
> 
> > The domain lookup for linux-mips.org fails for quite some time now. Hence,
> > webpages, the patchwork instance and Ralf Baechle's email there is not
> > reachable anymore.
> 
>  Well, mail forwarding has now been set up for my old LMO address, and so 
> I believe for Ralf's.  Any other resources remain unavailable.
> 
> > In the discussion of that patch series, Kurt Martin promised to get
> > linux-mips.org back online. Four months have now passed and the webpage is
> > still not back online. So, I suggest to remove these dead references.
> > Probably, we do not lose much if the linux-mips.org webpage never comes back.
> 
>  While most resources have been migrated I think the wiki was unique and 
> valuable.  Perhaps we could preserve read-only references to archive.org 
> dumps?  It's not clear to me what our policy is here though, if any.

Perhaps better to wholesale copy the content and keep it
around somewhere else like lore.kernel.org.


