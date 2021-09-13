Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF54D4087AF
	for <lists+linux-edac@lfdr.de>; Mon, 13 Sep 2021 10:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbhIMJAb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Sep 2021 05:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236022AbhIMJAb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 13 Sep 2021 05:00:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F414461029;
        Mon, 13 Sep 2021 08:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631523556;
        bh=CwfHxitG9wk52V601afoOOoBW02DjRN5SudCah4N5Uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+GO5J1bNRJgY7k+CL+jaxFuXEHPHGwmbTU/cTgaE7Ik0XfWZUgKXtPEuyfNRogcH
         YUMVsz7iHJV0hHFNXCgeaWJbt8o65LNt2RLEVbEDhjLC3vWjF8R0laBnmFS/UCMBJM
         nGx2YL5udEKiH7eNa2J4FgP29EeoWWUT5PAxR+vWW8lcOog/HB4Y38Po6rWZDttq+2
         YXqN0WHt749l0I8/JAIXxJmOOTMXP8qv8ICVemxpTS/Y52J822nTh8A5MiwgyXn2QA
         4jY+8C2tdqi7ZxQtHtgUcX3QnBVofTDrzAUBhEI1FutV6L5nYq3LFn2BsoHCsNFcSL
         RX/RpR3JRMDxQ==
Date:   Mon, 13 Sep 2021 10:59:10 +0200
From:   Robert Richter <rric@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Joe Perches <joe@perches.com>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/mc: Prefer strscpy or scnprintf over strcpy, sprintf
 and snprintf
Message-ID: <YT8S3poKyd5Nr5cK@rric.localdomain>
References: <20210903150539.7282-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903150539.7282-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Len,

On 03.09.21 17:05:39, Len Baker wrote:
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
> 
> The main reason behind this patch is to remove all the strcpy() uses
> from the kernel with the purpose to clean up the proliferation of
> str*cpy() functions. Later on, the next step will be remove all the
> strcpy implementations [2].
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
> [2] https://github.com/KSPP/linux/issues/88
> 
> Co-developed-by: Joe Perches <joe@perches.com>
> Signed-off-by: Joe Perches <joe@perches.com>
> Signed-off-by: Len Baker <len.baker@gmx.com>

this patch looks good to me. I made some changes on top of it to
further ease pointer arithmetic and also fix remaining
sprintf/snprintf() users as it makes sense to have them all in a
single change. See below. Boris, please apply.

Thanks,

-Robert

From 01a3c62a533e71984dfff7189e247b3e848f1449 Mon Sep 17 00:00:00 2001
From: Len Baker <len.baker@gmx.com>
Date: Fri, 3 Sep 2021 17:05:39 +0200
Subject: [PATCH] EDAC/mc: Prefer strscpy or scnprintf over strcpy, sprintf
 and snprintf

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy().
[1][2]

However, to simplify and clarify the code, to concatenate labels use
the scnprintf() function. This way it is not necessary to check the
return value of strscpy (-E2BIG if the parameter count is 0 or the src
was truncated) since the scnprintf returns always the number of chars
written into the buffer. This function returns always a nul-terminated
string even if it needs to be truncated.

While at it, fix all other broken string generation code that wrongly
interprets snprintf()'s return code or just uses sprintf(), implement
that using scnprintf() here too. Drop breaks in loops around
scnprintf() as it is safe now to loop. Moreover, the check is
needless: For the case when the buffer is exhausted, len never gets
zero because scnprintf() takes the full buffer length as input
parameter, but excludes the trailing '\0' in its return code and thus,
1 is the minimum len.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
[2] https://github.com/KSPP/linux/issues/88

 [ rric: Replace snprintf() with scnprintf(), rework sprintf() user,
   drop breaks in loops around scnprintf(), introduce 'end' pointer to
   reduce pointer arithmetic, use prefix pattern for e->location,
   adjust subject and description ]

Co-developed-by: Joe Perches <joe@perches.com>
Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Len Baker <len.baker@gmx.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/edac/edac_mc.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 2c5975674723..9f82ca295353 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -66,14 +66,12 @@ unsigned int edac_dimm_info_location(struct dimm_info *dimm, char *buf,
 	char *p = buf;
 
 	for (i = 0; i < mci->n_layers; i++) {
-		n = snprintf(p, len, "%s %d ",
+		n = scnprintf(p, len, "%s %d ",
 			      edac_layer_name[mci->layers[i].type],
 			      dimm->location[i]);
 		p += n;
 		len -= n;
 		count += n;
-		if (!len)
-			break;
 	}
 
 	return count;
@@ -341,19 +339,16 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 		 */
 		len = sizeof(dimm->label);
 		p = dimm->label;
-		n = snprintf(p, len, "mc#%u", mci->mc_idx);
+		n = scnprintf(p, len, "mc#%u", mci->mc_idx);
 		p += n;
 		len -= n;
 		for (layer = 0; layer < mci->n_layers; layer++) {
-			n = snprintf(p, len, "%s#%u",
-				     edac_layer_name[mci->layers[layer].type],
-				     pos[layer]);
+			n = scnprintf(p, len, "%s#%u",
+				      edac_layer_name[mci->layers[layer].type],
+				      pos[layer]);
 			p += n;
 			len -= n;
 			dimm->location[layer] = pos[layer];
-
-			if (len <= 0)
-				break;
 		}
 
 		/* Link it to the csrows old API data */
@@ -1027,12 +1022,13 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
 			  const char *other_detail)
 {
 	struct dimm_info *dimm;
-	char *p;
+	char *p, *end;
 	int row = -1, chan = -1;
 	int pos[EDAC_MAX_LAYERS] = { top_layer, mid_layer, low_layer };
 	int i, n_labels = 0;
 	struct edac_raw_error_desc *e = &mci->error_desc;
 	bool any_memory = true;
+	const char *prefix;
 
 	edac_dbg(3, "MC%d\n", mci->mc_idx);
 
@@ -1087,6 +1083,8 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
 	 */
 	p = e->label;
 	*p = '\0';
+	end = p + sizeof(e->label);
+	prefix = "";
 
 	mci_for_each_dimm(mci, dimm) {
 		if (top_layer >= 0 && top_layer != dimm->location[0])
@@ -1114,12 +1112,8 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
 			p = e->label;
 			*p = '\0';
 		} else {
-			if (p != e->label) {
-				strcpy(p, OTHER_LABEL);
-				p += strlen(OTHER_LABEL);
-			}
-			strcpy(p, dimm->label);
-			p += strlen(p);
+			p += scnprintf(p, end - p, "%s%s", prefix, dimm->label);
+			prefix = OTHER_LABEL;
 		}
 
 		/*
@@ -1141,25 +1135,25 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
 	}
 
 	if (any_memory)
-		strcpy(e->label, "any memory");
+		strscpy(e->label, "any memory", sizeof(e->label));
 	else if (!*e->label)
-		strcpy(e->label, "unknown memory");
+		strscpy(e->label, "unknown memory", sizeof(e->label));
 
 	edac_inc_csrow(e, row, chan);
 
 	/* Fill the RAM location data */
 	p = e->location;
+	end = p + sizeof(e->location);
+	prefix = "";
 
 	for (i = 0; i < mci->n_layers; i++) {
 		if (pos[i] < 0)
 			continue;
 
-		p += sprintf(p, "%s:%d ",
-			     edac_layer_name[mci->layers[i].type],
-			     pos[i]);
+		p += scnprintf(p, end - p, "%s%s:%d", prefix,
+			       edac_layer_name[mci->layers[i].type], pos[i]);
+		prefix = " ";
 	}
-	if (p > e->location)
-		*(p - 1) = '\0';
 
 	edac_raw_mc_handle_error(e);
 }
-- 
2.30.2

