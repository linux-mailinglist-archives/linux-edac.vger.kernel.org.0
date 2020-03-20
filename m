Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E82E818C8F4
	for <lists+linux-edac@lfdr.de>; Fri, 20 Mar 2020 09:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgCTI0o (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Mar 2020 04:26:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32924 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCTI0o (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 20 Mar 2020 04:26:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id z10so4606993ljn.0;
        Fri, 20 Mar 2020 01:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9CIUrS+yZvKhtjJWNPvxGGOXzlMi85cVkUe2m48ghlk=;
        b=d8rMsEwbPVmnRmauEpCLGwHg6JCgRiWAocuacvN2eGLw2gVI4vni2xWq4AgwLwEvns
         X7Ttru3G2Sd/y6wa7KH9EgegvQLgnNQOW4tLGvw036izfa2jwocQoI4fmg7sXXKF8Xe4
         Q/bXsjUv+2aqI4cdV2Z55rncNGGVahX/qNA4mFzFwa6Tnz5/qcBvSvpLuK/Hq9m6rojb
         b4FWwBB0WbInQ+uL4AlFbibMrpx/Xg8qPp0gWgDKCmZP30lMGPfj8E7kr1cH8IpmKoWw
         ILcRrLY4uWHSfzlqjkhjQ3wDOzvqmxWUgajawSK/31839rXIsI9X02q+qmd5MyrwqT5g
         GUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9CIUrS+yZvKhtjJWNPvxGGOXzlMi85cVkUe2m48ghlk=;
        b=DJkRA6GxL5gzG/lI0xbSin83XTkJWtoED6ZKmYH5p6V5OAjTu+rrqFiPsWiLzXjO4e
         MW76PQdhuNUSgx7U/CaFLUedpJoP/T6tNTdoYA9Grvqc0BDwJbL/do99yKJIQWjUDOpH
         kVL6DOprwKmT/LC8MSGrTf1DjrneB2yw+yyVYBuFBChtxPEN1bSaqd41zF+kP0xAfnJ+
         KLgdQCiqrDxyXWzTDOE1sULu7DtxX4GT0bQVjGxCRLfcj36ml+0U3+zgpJoFK3BsgJM7
         ht5m2ntntogvKRfk1SMqcnmhbjcPF5lvZaxvzmM0FifP6KAkx4Yv0UTDrQ8Yu7iIZ0N+
         rs2A==
X-Gm-Message-State: ANhLgQ0Qg6cQbAv4IgC6sk5HA+PiR4WPEHnUsqW3SPwrJzSnrnMV7pdx
        fNWNMeTSdmAUwMj4lP2PrIxUP3NVFVy1HavVxDc=
X-Google-Smtp-Source: ADFU+vuxJXh8HfEyPsTCLNlvKGQcHF6YmFcyg5hqvcVu5xENOn3WA8Up+vtfjzm63zckWq4451IYWZ9/5oBPFRjZF+o=
X-Received: by 2002:a2e:b0f0:: with SMTP id h16mr4488839ljl.48.1584692801092;
 Fri, 20 Mar 2020 01:26:41 -0700 (PDT)
MIME-Version: 1.0
From:   "she90122 ." <she90122@gmail.com>
Date:   Fri, 20 Mar 2020 16:26:30 +0800
Message-ID: <CAMhTFw=OUaVSLGz1tyHJYiq6UXBNni5=fBp16M7vPXjA0HHEEA@mail.gmail.com>
Subject: [v2,1/1] EDAC: (pnd2) Fix the log level and remove the word "error"
 for message "Failed to register device with error %d"
To:     she90122 <she90122@gmail.com>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Amy.Shih" <Amy.Shih@advantech.com.tw>,
        "Oakley.Ding" <Oakley.Ding@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Amy Shih <amy.shih@advantech.com.tw>

Fix the log level from "KERN_ERR" to "KERN_INFO" and remove the word
"error" for message "Failed to register device with error %d", since
it is not the error message but the information to notice the user.

Signed-off-by: Amy Shih <amy.shih@advantech.com.tw>
---
Changes in v2:
- Remove the word "error" from output message.
---
 drivers/edac/pnd2_edac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c index
933f772..399da3e 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1572,7 +1572,8 @@ static int __init pnd2_init(void)

  rc = pnd2_probe();
  if (rc < 0) {
- pnd2_printk(KERN_ERR, "Failed to register device with error %d.\n", rc);
+ pnd2_printk(KERN_INFO,
+     "Failed to register device - %d.\n", rc);
  return rc;
  }

--
1.8.3.1
