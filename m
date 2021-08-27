Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600FD3F9F9C
	for <lists+linux-edac@lfdr.de>; Fri, 27 Aug 2021 21:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhH0TJX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Aug 2021 15:09:23 -0400
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:35074 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230221AbhH0TJW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 27 Aug 2021 15:09:22 -0400
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 551C7181370A0;
        Fri, 27 Aug 2021 19:08:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id A022D1E04D5;
        Fri, 27 Aug 2021 19:08:30 +0000 (UTC)
Message-ID: <bdc0dbee0f60823ccc6a5cd0a25a8242dd94c215.camel@perches.com>
Subject: Re: [PATCH v4] EDAC/mc: Prefer strscpy over strcpy
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>, Len Baker <len.baker@gmx.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Aug 2021 12:08:28 -0700
In-Reply-To: <YSkmv8kz2z3OBHVe@zn.tnic>
References: <20210814075527.5999-1-len.baker@gmx.com>
         <YSPbOo90alPsv4vL@zn.tnic> <20210824090338.GB7999@titan>
         <YSU5wp/ZpsXuDgmu@zn.tnic> <20210827173633.GA3040@titan>
         <YSkmv8kz2z3OBHVe@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.94
X-Stat-Signature: rnq8dik9jk6dm8eigjyka9wd7ha9tycw
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: A022D1E04D5
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX199FhWeVlOO1aX/0GGpp0KsHw50NmpmSZk=
X-HE-Tag: 1630091310-308896
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, 2021-08-27 at 19:54 +0200, Borislav Petkov wrote:
> So it would be a lot more robust if something would catch that change,
> albeit seemingly redundant now.

I still think scnprintf is _way_ more common and intelligible as
a construct than this odd strscpy with required error checking.


