Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ACC79F051
	for <lists+linux-edac@lfdr.de>; Wed, 13 Sep 2023 19:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjIMRVB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Sep 2023 13:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjIMRVA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Sep 2023 13:21:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F0BA3
        for <linux-edac@vger.kernel.org>; Wed, 13 Sep 2023 10:20:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58ee4df08fbso562917b3.3
        for <linux-edac@vger.kernel.org>; Wed, 13 Sep 2023 10:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694625656; x=1695230456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SCfSG6mCnW0qyfFGMhWtptM2uKei1bLEhKpvdaKI0EM=;
        b=mbVlcO2zidVtaVhja0n27bJA5JUPBLrMqWLDu03p6zWIreTemgObvDj2JT3YXbp/PP
         0mERMOgi5CZPe/zPpHIIsl4oIdAA/iQA5Gopi8qOGHAGhdwuCn7h3JzzQ7lAeFU0Q6ET
         ac3b5t98vS0KIuDXViyhVC3p/SsvxTBEIqf4PsnysO8Sl1u9elhWDKui4ghQ2Hd8WWwQ
         NoiBRhvUrlvtXhtYRr7AHNiQdvYCDwkx6acthwaz3n/B7yzzGyPhz4FG4jKWrDYTI0xB
         7fMt7l7YkfJkbjO8oqZ1XSZfozRa9mojuFm/M6hQSkzdkA7eoglfhg+ZaLmBkmwPNSrn
         tAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694625656; x=1695230456;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SCfSG6mCnW0qyfFGMhWtptM2uKei1bLEhKpvdaKI0EM=;
        b=P0PL28E+UrMU39tZm8s8s0arstLNBILYlrvBDM7qR3G+qiNT2tT1uwgg6u86WMVJ3b
         m57zQ+tQZmdnWDXn/jGCe7XdrKkve1dXDv6PoLx/AZfasBR6fZQenjNZGJaSDeYZ2dA9
         ihNjn3oEiadz21CKz5a89sZaH1UE/rkDAESf0d4glr544bmSYsIK74569zEsgf3q1NRr
         +58xSvEUDMlaCiJt/fHqJXDoU6ksjidy65Xnl0ukFiMbqNjHkr4dpRkKvJ9AXmXLchwy
         q/VE+iw7+bIQzVR33jso0RpOA32CsYfD3Z9CoES4F5y57fBI2q86MRBvwCGEkpJbZNWz
         sKlg==
X-Gm-Message-State: AOJu0YwBsDH1gyxglebgyIul9Kqdk6bPc5ogMp8jYXPd5EjAF0w5aMLt
        kdGFuoUAkdCKuUu1UdYSvczrRXhjpuzQX3aADw==
X-Google-Smtp-Source: AGHT+IHmZqG7+RKPg5oWQee0z9k9bPQgJZLAzA5rk6LcXiW5RHunFlSaUBTGy88s7nRwnv+MUI+mv7kvTmKVj2ZfyQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:4522:0:b0:59b:ca80:919e with SMTP
 id s34-20020a814522000000b0059bca80919emr50177ywa.0.1694625655805; Wed, 13
 Sep 2023 10:20:55 -0700 (PDT)
Date:   Wed, 13 Sep 2023 17:20:50 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHHvAWUC/52NwQqDMBAFf0VybkqysVJ76n+UIiZZNVCNZCU0i
 P/e6K3H9vJg3mFmZYTBIbFbsbKA0ZHzUwZ1KpgZ2qlH7mxmBgKUqKXitITJzInb4CIG4mhbc0w
 zmoYSdcQzV7LWQkgoW8Wyag7YufeReTwzD44WH9JRjXJ/fwxEySW3oOBaSy0uWtx77/sXno0f2 V6I8I8VshUsYKVtqaoSvqzbtn0AqJbMzS8BAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694625654; l=2145;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=rHRbEEg76Fmzd3MgqtwO/Ydw/98CvZy1Bgwo8SLGEU8=; b=t9+RA3S3Zt+d24hZNYz4lNO+qJ9Nkfkp9t7nbfQbXU15aWNksTlAFug+khYhTUHKD5Ak2gdAU
 vZ9gixMYyYUB2tnTzpUBemu2Ekkb7/ti0NUblWa/3B8a28wJup3ZbE6
X-Mailer: b4 0.12.3
Message-ID: <20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v3-1-38c1db7d207f@google.com>
Subject: [PATCH v3] EDAC/mc_sysfs: refactor deprecated strncpy
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

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without needlessly
NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v3:
- prefer strscpy to strscpy_pad (thanks Tony)
- Link to v2: https://lore.kernel.org/r/20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v2-1-2d2e6bd43642@google.com

Changes in v2:
- included refactor of another strncpy in same file
- Link to v1: https://lore.kernel.org/r/20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v1-1-d232891b05b0@google.com
---
Note: build-tested only.
---
 drivers/edac/edac_mc_sysfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 15f63452a9be..9a5b4bbd8191 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -229,8 +229,7 @@ static ssize_t channel_dimm_label_store(struct device *dev,
 	if (copy_count == 0 || copy_count >= sizeof(rank->dimm->label))
 		return -EINVAL;
 
-	strncpy(rank->dimm->label, data, copy_count);
-	rank->dimm->label[copy_count] = '\0';
+	strscpy(rank->dimm->label, data, copy_count);
 
 	return count;
 }
@@ -535,7 +534,7 @@ static ssize_t dimmdev_label_store(struct device *dev,
 	if (copy_count == 0 || copy_count >= sizeof(dimm->label))
 		return -EINVAL;
 
-	strncpy(dimm->label, data, copy_count);
+	strscpy(dimm->label, data, copy_count);
 	dimm->label[copy_count] = '\0';
 
 	return count;

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230913-strncpy-drivers-edac-edac_mc_sysfs-c-e619b00124a3

Best regards,
--
Justin Stitt <justinstitt@google.com>

