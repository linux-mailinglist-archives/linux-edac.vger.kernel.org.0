Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC0C79DD87
	for <lists+linux-edac@lfdr.de>; Wed, 13 Sep 2023 03:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjIMB03 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Sep 2023 21:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbjIMB03 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 12 Sep 2023 21:26:29 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E04F1706
        for <linux-edac@vger.kernel.org>; Tue, 12 Sep 2023 18:26:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-597f461adc5so69653467b3.1
        for <linux-edac@vger.kernel.org>; Tue, 12 Sep 2023 18:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694568384; x=1695173184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=42nX+Yobaw2ArjAJMtixTW6UpiTmF6+i2Dxfn02Z0cM=;
        b=dDCdEz1fpnSHxepx83WCRH6TxueF2PrFTF8xE0PqV8lD6CcSnXFvBRYsERpkl0g+y5
         ngWQ206tiRUPlkWT6ZwYSbOmXdgOuvzWugM8Xry8WnxI0OKyrfNBbY3BGucBKp4cG9Dc
         vhGa9/3ftdtsBH9IitvEk9II2x7gErFUE7ZKtqPU0Hx/sNCLKy8o/dmKYqrAPJXLDkZO
         iVEy/2RIkNQjSCpBBioGYNKsch5/23HLA8uWPcwJxnP/XJ5G6Ki+hAjyrSPmEE8JnEKZ
         qYzfF6ZtOh/sfllSFOSchfsW7gevP10aoUfxI/6rXENV6Pjl/EbQR8oNml9s9xtCnW+X
         TiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694568384; x=1695173184;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42nX+Yobaw2ArjAJMtixTW6UpiTmF6+i2Dxfn02Z0cM=;
        b=rKIoUTxyRUZGjucFQxTr1XBgbamREo21Ls5yxM6c1SInbtbd0IqNLx8K5rbzQfq25B
         iBLGhWQv6xd9OU4roRy8opFgjlMIzd1XplkUKv3gjP20iVNupI5nGyPWa/pFCAzhrx8O
         n+b7COc1R4obyT13uPF79izz9K1H3HvjqJt3u1QaKzLK9yjFzSIq2xAG2R9aYStmtWE6
         XzV1jlMKZnf1aVbTX4gYuxdc27n415g9qMEPVI0U+uk4Kef2lD8wc4W5gZ0offY4B0ea
         ckd6KpufXZnvOw+ckvSXnUyhfr6iuix7p19PkZRHBvWqYDhNNwx0SPYBNLnOJFqBtdgk
         E2RQ==
X-Gm-Message-State: AOJu0YwfetLjHYgFh2pAHUlpHlaz/ETJ/fUH5OVWMLfYaS9811uvE0Pl
        U/wve3RIZpqpb4Y4x3mY2p+6iI7zD8YszIChIA==
X-Google-Smtp-Source: AGHT+IGkNiQddAhnPvwHE7ghwj6ge/1myo/zEeDIjB62oFApi1y/kkndrD8b9r+BvlQVjbD8aZXgt4KvvKpLUB/nyA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:a06:b0:d80:bea:cbb4 with SMTP
 id cb6-20020a0569020a0600b00d800beacbb4mr23981ybb.5.1694568384316; Tue, 12
 Sep 2023 18:26:24 -0700 (PDT)
Date:   Wed, 13 Sep 2023 01:26:23 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAL4PAWUC/x3NywqDMBCF4VeRWTuQixT0VUqRNJm0s2iUGZGK+
 O6GbA58m/OfoCRMClN3gtDOykupsH0H8RvKh5BTNTjjvBmtR92kxPXAJLyTKFIKsc38i7MemhW rH3Z8G2PdEDzUq1Uo879lnq/rugHkG0Y5dgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694568383; l=1656;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=a+gdXE2iWidU2yJZiH3fOKoz8Q6mDOLlN7Uv1qN4FVM=; b=Mv8MVJCcN9KBnoTF4HQ0BVotYpkN2Wjo4juaPRuNp8uPo5pEqbChN82bq4BeMkgADnBRqtVFK
 +R9SEb26aU+CM1gp5LAYEhYqCmLFurfQbnjWO9fMyFQtOFccAepTpld
X-Mailer: b4 0.12.3
Message-ID: <20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v1-1-d232891b05b0@google.com>
Subject: [PATCH] EDAC/mc_sysfs: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy_pad` [2] due to the fact that it guarantees
NUL-termination on the destination buffer whilst maintaining the
NUL-padding behavior that `strncpy` provides. This may not be strictly
necessary but as I couldn't understand what this code does I wanted to
ensure that the functionality is the same.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/edac/edac_mc_sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 15f63452a9be..b303309a63cf 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -229,8 +229,7 @@ static ssize_t channel_dimm_label_store(struct device *dev,
 	if (copy_count == 0 || copy_count >= sizeof(rank->dimm->label))
 		return -EINVAL;
 
-	strncpy(rank->dimm->label, data, copy_count);
-	rank->dimm->label[copy_count] = '\0';
+	strscpy_pad(rank->dimm->label, data, copy_count);
 
 	return count;
 }

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230913-strncpy-drivers-edac-edac_mc_sysfs-c-e619b00124a3

Best regards,
--
Justin Stitt <justinstitt@google.com>

