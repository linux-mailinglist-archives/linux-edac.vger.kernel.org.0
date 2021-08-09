Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BB33E4AB3
	for <lists+linux-edac@lfdr.de>; Mon,  9 Aug 2021 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhHIRTY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Aug 2021 13:19:24 -0400
Received: from smtprelay0155.hostedemail.com ([216.40.44.155]:56044 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233656AbhHIRTX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Aug 2021 13:19:23 -0400
Received: from omf01.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 96F2F1802F048;
        Mon,  9 Aug 2021 17:19:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 0A01517275;
        Mon,  9 Aug 2021 17:18:59 +0000 (UTC)
Message-ID: <99448ef29830fda9b19409bc23b0e7513b22f7b7.camel@perches.com>
Subject: Re: [PATCH v3] drivers/edac/edac_mc: Remove all strcpy() uses
From:   Joe Perches <joe@perches.com>
To:     Robert Richter <rric@kernel.org>, Len Baker <len.baker@gmx.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 09 Aug 2021 10:18:58 -0700
In-Reply-To: <YRD90L6PMoVbbv+9@rric.localdomain>
References: <20210807155957.10069-1-len.baker@gmx.com>
         <ff02ffffdc130a772c01ec0edbf8d1e684b0730a.camel@perches.com>
         <20210808112617.GA1927@titan> <YRD90L6PMoVbbv+9@rric.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0A01517275
X-Spam-Status: No, score=-1.58
X-Stat-Signature: p5kr8prgqazzpziseafgjpraffk61fyt
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX180VX6TKfp7KxpfCdiqElP3tLF2OZGglEw=
X-HE-Tag: 1628529539-872985
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 2021-08-09 at 12:05 +0200, Robert Richter wrote:
> On 08.08.21 13:26:17, Len Baker wrote:
> 
> > > Perhaps this should use scnprintf rather than strscpy
> > > Something like:
> > > 			n += scnprintf(buf + n, len - n, "%s",
> > > 				       p == e->label ? dim->label : OTHER_LABEL);
> > > 
> > In the first version [1] the scnprintf was used but Robert Richter don't
> > see any benefit compared with the current implementation.
> > 
> > [1] https://lore.kernel.org/linux-hardening/20210725162954.9861-1-len.baker@gmx.com/
> 
> Reason is that there is the assumption that p must always point at the
> end of the string and its trailing zero byte. I am not opposed using
> the string function's return code instead of strlen() to get the
> length. But why using formated output if strscpy() can be used?

strscpy and scnprintf have different return values and it's simpler
and much more common to use scnprintf for appended strings that are
limited to a specific buffer length.



