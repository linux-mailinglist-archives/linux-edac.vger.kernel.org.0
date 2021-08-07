Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DA03E3671
	for <lists+linux-edac@lfdr.de>; Sat,  7 Aug 2021 19:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhHGRKI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 7 Aug 2021 13:10:08 -0400
Received: from smtprelay0060.hostedemail.com ([216.40.44.60]:50756 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229464AbhHGRJ7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 7 Aug 2021 13:09:59 -0400
Received: from omf05.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 10F18180A6B25;
        Sat,  7 Aug 2021 17:09:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 6C3FAB279A;
        Sat,  7 Aug 2021 17:09:36 +0000 (UTC)
Message-ID: <ff02ffffdc130a772c01ec0edbf8d1e684b0730a.camel@perches.com>
Subject: Re: [PATCH v3] drivers/edac/edac_mc: Remove all strcpy() uses
From:   Joe Perches <joe@perches.com>
To:     Len Baker <len.baker@gmx.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 07 Aug 2021 10:09:35 -0700
In-Reply-To: <20210807155957.10069-1-len.baker@gmx.com>
References: <20210807155957.10069-1-len.baker@gmx.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.02
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 6C3FAB279A
X-Stat-Signature: n4hcyyu6anzh374wpysy3on4pq1dhah3
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+bwEvB5NWa1nQgJWJ9oIrQ9TMATuZFR+k=
X-HE-Tag: 1628356176-500637
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, 2021-08-07 at 17:59 +0200, Len Baker wrote:
> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors. The safe replacement is strscpy().

Probably better to change the commit subject to something like
what is generally used by the subsystem.

Maybe:
	EDAC/mc: Convert strcpy to strscpy
or
	EDAC/mc: Prefer strscpy over strcpy

and also:

> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
[]
> @@ -1113,11 +1115,11 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  			p = e->label;
>  			*p = '\0';
>  		} else {
> -			if (p != e->label) {
> -				strcpy(p, OTHER_LABEL);
> -				p += strlen(OTHER_LABEL);
> -			}
> -			strcpy(p, dimm->label);
> +			const char *text = (p != e->label) ? OTHER_LABEL :
> +				dimm->label;
> +
> +			strscpy(p, text, len);
> +			len -= strlen(p);
>  			p += strlen(p);

Perhaps this should use scnprintf rather than strscpy
Something like:
			n += scnprintf(buf + n, len - n, "%s",
				       p == e->label ? dim->label : OTHER_LABEL);



