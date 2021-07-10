Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5963C35AE
	for <lists+linux-edac@lfdr.de>; Sat, 10 Jul 2021 19:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhGJRBf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Jul 2021 13:01:35 -0400
Received: from smtprelay0154.hostedemail.com ([216.40.44.154]:57112 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229546AbhGJRBf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Sat, 10 Jul 2021 13:01:35 -0400
Received: from omf03.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 2274F18012002;
        Sat, 10 Jul 2021 16:58:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id C8A9F13D93;
        Sat, 10 Jul 2021 16:58:47 +0000 (UTC)
Message-ID: <d95595021eb8da542960fff9b40dc7c308661c9e.camel@perches.com>
Subject: Re: [RESEND] edac: replace sprintf() by scnprintf()
From:   Joe Perches <joe@perches.com>
To:     Salah Triki <salah.triki@gmail.com>, bp@alien8.de,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 10 Jul 2021 09:58:46 -0700
In-Reply-To: <20210710163505.GA689509@pc>
References: <20210710163505.GA689509@pc>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C8A9F13D93
X-Spam-Status: No, score=1.60
X-Stat-Signature: zbsk4wxe1dq9ow4qkp4dca31rg6w5x9f
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+eE83VJUeJeyyUpGGi7QAvFfznHecaVyQ=
X-HE-Tag: 1625936327-540020
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, 2021-07-10 at 17:35 +0100, Salah Triki wrote:
> Replace sprintf() by scnprintf() in order to avoid buffer overflows.

While of course safe, this is not strictly necessary as the
maximum length of any edac_layer_name is 8 bytes.

drivers/edac/edac_mc.c:const char *edac_layer_name[] = {
drivers/edac/edac_mc.c- [EDAC_MC_LAYER_BRANCH] = "branch",
drivers/edac/edac_mc.c- [EDAC_MC_LAYER_CHANNEL] = "channel",
drivers/edac/edac_mc.c- [EDAC_MC_LAYER_SLOT] = "slot",
drivers/edac/edac_mc.c- [EDAC_MC_LAYER_CHIP_SELECT] = "csrow",
drivers/edac/edac_mc.c- [EDAC_MC_LAYER_ALL_MEM] = "memory",
drivers/edac/edac_mc.c-};

And name is:

		char name[80];

I suppose name[80] could be changed to name[32] or so
at the same time to reduce stack usage.

Maybe name should be moved into the loop too.

---
 drivers/edac/debugfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/debugfs.c b/drivers/edac/debugfs.c
index 4804332d99465..a41071f2ad428 100644
--- a/drivers/edac/debugfs.c
+++ b/drivers/edac/debugfs.c
@@ -55,14 +55,15 @@ void edac_debugfs_exit(void)
 void edac_create_debugfs_nodes(struct mem_ctl_info *mci)
 {
 	struct dentry *parent;
-	char name[80];
 	int i;
 
 	parent = debugfs_create_dir(mci->dev.kobj.name, edac_debugfs);
 
 	for (i = 0; i < mci->n_layers; i++) {
-		sprintf(name, "fake_inject_%s",
-			     edac_layer_name[mci->layers[i].type]);
+		char name[32];
+
+		scnprintf(name, sizeof(name), "fake_inject_%s",
+			  edac_layer_name[mci->layers[i].type]);
 		debugfs_create_u8(name, S_IRUGO | S_IWUSR, parent,
 				  &mci->fake_inject_layer[i]);
 	}


