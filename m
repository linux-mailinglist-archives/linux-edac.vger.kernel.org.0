Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BC868004C
	for <lists+linux-edac@lfdr.de>; Sun, 29 Jan 2023 17:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjA2Qv1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 29 Jan 2023 11:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2Qv0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 29 Jan 2023 11:51:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C3112872;
        Sun, 29 Jan 2023 08:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1675011067; bh=km46yd4qIJBVuNQprXNORGM4DbSKBCYP5qjK7u3Uo7U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=LDB76N1ZFdvY3bHbDvaas79pQlyu7Em5GWPlssN48JqqYphO//qIpZBWmzUU+lDRA
         ywsbhcQoHr7Xm/j/Mnc9RFeABo38ejNaQflGwKuRWN3HKhKDEnF0zATMZs5gpWzzkl
         vjKsBDER+QOpOLDpmwjBM3nJvic2SLM8rjP5WAdmGNeVoAVVZDtkPkVLmguOYlttkU
         18DUNvq2na9ZvZbUGSYm+aMQ0aTxQ3qd+qM8A36PAhTJb7VR5HTGdqUsUvWlrC8ZvQ
         VKP5Z0MJTkFqRw5/y7fFV23zf92zWYD+Sqn+vF79eURhyO/p7btC05CzYmglQk6Mz9
         vIiBCV54VYCtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUjC-1oUkxd2f90-00rWTH; Sun, 29
 Jan 2023 17:51:07 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-edac@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/amd81*1: Remove "\n" from MODULE_AUTHOR
Date:   Sun, 29 Jan 2023 17:50:54 +0100
Message-Id: <20230129165054.1675554-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XEQm93g/nsQ4EoQrU94Xx5wNw3FiUrqb9lqs0Cw2r+bE3ZAJyg5
 0MhNnirDszcv6TUrrNboJqeRTP/LWC9Qk1ZSmsPsUkjBSZxjoSiooziw2VsOO2GxIoVFNi2
 uD8ebWPTqOs/TxSyS6F1TFJequsoDfWchDIPgwWiqp2THYYOMd7qwuTM5urlzlkfBP9BMmV
 IhLfXqFMRzJzOBEkE71QQ==
UI-OutboundReport: notjunk:1;M01:P0:zr5rt1gYX6g=;rSGxwWl/S/WqZbyg67Fw8I96Fux
 jVLSeGC7lUsoBQgii8PA+Q+E/OAIUrCoYlVJXNZK4VIpe/TEpbminEgKTJUC01ZGNld3v1HFT
 ux8xh42NG22y0ORCzph3gZIcA/YKgY3i/lg/oSvN9zq16LpPEdFvvIYgx+qTsnTVFn/N7otx4
 MQ7AOIoxW8igKkY9fmoyd9oskWyTa3uBBy7+5pb7XPj5AAi+PKyk3yRIByIsfLFcQlTQBIefN
 uOgshz+KAGD8Yfhnf+Pl9xpv3EDCA4mNiRnNL9L2GQgUQbf8PkdyZugP6cpjfaytBKqXWVSWX
 V7ZcMdKwep8EJTzvKB/SeRyAk3mgExS+sa44eka+8oE2WBhB4MsaIVDsSJjUZ35QbxERiPbut
 1xq1CN8SFNrNTX+mR8pyF68vwASnzg0j46qvhZwbogePGmwEJ+ULdhFbQS0jqKvjruYDo5J5B
 xVHryW57A5zXOyee8HNeDBQwjvF8UBYkbC9w/XhxEUYfQPgOedC7kUYsekLndeoHuMOT9HNhM
 4KDyFpiZDqMMPpKSQ/5JVITlLnfqoSR1Bdc2X3sW8p4C42c3CA4583PgrZOcBZgFtXKcfeOGP
 /McnvHYtbw2Y8Bj0PaM+mhPfbbx0PLBkxsYIh4H5tqHXKkBWVfrv35763Ph8crfwfsGlec9+2
 LfFfjG5Nfx+c6iOOsVFBXG7+bkmRHxBv0VOnTPm/osnx/vfFOiDaUwKLrzntPZXfVLm6tiSB2
 s7wIZBgzMC1xOjEfYqWv1f7+2aJBAnzuRI7sR88DYQv/K9/ot9DJEyoX7NSpxKsPZlDRxA0du
 Y+uJky1YM1Ccy8UaH5qVppP5We9+c9fykEgz1tAlTFNnJ7WyuUemxXLILaQYjhzi550+Uta8A
 2oBLgqED5zrCmBoO2siOA2KdV7hGVzLB2MhqH+fVHKBULTGuYVFSQZmo2UyXtRYhhWu+3bbuM
 I63N3k6sWp/yKjVq5EH85BbxfLw=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

MODULE_AUTHOR strings don't usually include a newline character.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/edac/amd8111_edac.c | 2 +-
 drivers/edac/amd8131_edac.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd8111_edac.c b/drivers/edac/amd8111_edac.c
index 7508aa416ddbd..ca718f63fcbcd 100644
=2D-- a/drivers/edac/amd8111_edac.c
+++ b/drivers/edac/amd8111_edac.c
@@ -593,5 +593,5 @@ module_init(amd8111_edac_init);
 module_exit(amd8111_edac_exit);

 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Cao Qingtao <qingtao.cao@windriver.com>\n");
+MODULE_AUTHOR("Cao Qingtao <qingtao.cao@windriver.com>");
 MODULE_DESCRIPTION("AMD8111 HyperTransport I/O Hub EDAC kernel module");
diff --git a/drivers/edac/amd8131_edac.c b/drivers/edac/amd8131_edac.c
index 1693537109826..28610ba514f4d 100644
=2D-- a/drivers/edac/amd8131_edac.c
+++ b/drivers/edac/amd8131_edac.c
@@ -354,5 +354,5 @@ module_init(amd8131_edac_init);
 module_exit(amd8131_edac_exit);

 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Cao Qingtao <qingtao.cao@windriver.com>\n");
+MODULE_AUTHOR("Cao Qingtao <qingtao.cao@windriver.com>");
 MODULE_DESCRIPTION("AMD8131 HyperTransport PCI-X Tunnel EDAC kernel modul=
e");
=2D-
2.39.0

