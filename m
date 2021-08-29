Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448403FAD29
	for <lists+linux-edac@lfdr.de>; Sun, 29 Aug 2021 18:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhH2Qje (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 29 Aug 2021 12:39:34 -0400
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:58348 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235595AbhH2Qjd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Sun, 29 Aug 2021 12:39:33 -0400
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2902D180286D2;
        Sun, 29 Aug 2021 16:38:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 8230820D751;
        Sun, 29 Aug 2021 16:38:38 +0000 (UTC)
Message-ID: <7b6dc45194f28db52740c2a604550f6879dafe36.camel@perches.com>
Subject: Re: [PATCH v5] EDAC/mc: Prefer strscpy or scnprintf over strcpy
From:   Joe Perches <joe@perches.com>
To:     Len Baker <len.baker@gmx.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 29 Aug 2021 09:38:37 -0700
In-Reply-To: <20210829161547.6069-1-len.baker@gmx.com>
References: <20210829161547.6069-1-len.baker@gmx.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.10
X-Stat-Signature: kjeub665hd3eemhd18azphncp68gyjyo
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 8230820D751
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+6+/+VJDwyfpXsLyBJWe/JoPn23k2/juA=
X-HE-Tag: 1630255118-696944
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, 2021-08-29 at 18:15 +0200, Len Baker wrote:
> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors. The safe replacement is strscpy() [1].
> 
> However, to simplify and clarify the code, to concatenate labels use
> the scnprintf() function. This way it is not necessary to check the
> return value of strscpy (-E2BIG if the parameter count is 0 or the src
> was truncated) since the scnprintf returns always the number of chars
> written into the buffer. This function returns always a nul-terminated
> string even if it needs to be truncated.
[]
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
[]
> @@ -1113,12 +1116,11 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  			p = e->label;
>  			*p = '\0';
>  		} else {
> -			if (p != e->label) {
> -				strcpy(p, OTHER_LABEL);
> -				p += strlen(OTHER_LABEL);
> -			}
> -			strcpy(p, dimm->label);
> -			p += strlen(p);
> +			const char *or = (p != e->label) ? OTHER_LABEL : "";
> +
> +			n = scnprintf(p, len, "%s%s", or, dimm->label);
> +			len -= n;
> +			p += n;

A very common and intelligible mechanism for this is:

	const char *prefix = "";
	int n = 0;
	...
			n += scnprintf(e->label + n, sizeof(e->label) - n,
				       "%s%s", prefix, dimm->label);
			prefix = " or ";


