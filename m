Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF408B9EC7
	for <lists+linux-edac@lfdr.de>; Sat, 21 Sep 2019 17:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407696AbfIUP6H (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 21 Sep 2019 11:58:07 -0400
Received: from mout.web.de ([212.227.17.12]:41219 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407694AbfIUP6H (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 21 Sep 2019 11:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569081453;
        bh=NZyRZj6JCdK9cYIuWW8SPhSraVsjvvD3EVx+CjQ5DxY=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=N5WXFSjqurDZFcTP0VCqYQh0xa8RrAiG9OXhEvJBLmbEIB+cKBu5DsGRDZnyo0sIB
         5Iemqc4BwxFcjgAFTUSA+KzbRH7JtNifVdVuKHVxwNz7vKIhpJygIcsNSy5jEdyem0
         IiJccWlkh0fBX5HP8YHYTVNtNff2q48J+9q8AF/I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.64.44]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MhDkj-1iXva82BPd-00MO8t; Sat, 21
 Sep 2019 17:57:33 +0200
To:     linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?Q?Jan_L=c3=bcbbe?= <jlu@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] EDAC: Armada XP: Use devm_platform_ioremap_resource() in two
 functions
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3cf2076e-6394-4997-613d-cbf5b6dbee1e@web.de>
Date:   Sat, 21 Sep 2019 17:57:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V4KDaKpDGJk2tbrl0dbKCmeVsyRvg/r19joKrX82qZyw87ThdXd
 9leklZJLv0qVvuYtC+oN6rJ1F2lJSDWfMhVOdyeJf0+43zTyG3/zOkR6HuZZ5mJ3q0aFI1s
 LKYGhXuTWdWo+dKPmNIZAfqfWex+M795dmrsLi9bp1mt/uljwuCttDJJzDmUAV+I6jYv9cE
 BeYT122F6JW0O186lGjAQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fbTWqCFNNP8=:RBI9qB/tKa80ZHVGvCt8Se
 9C6FUbfqovalnxKNASSBYDty9GGlGQbVv7f2E31GgvyhLXkse8Zg/aSjBEO0hyGssNQXLQTi0
 fUIJiruyGcYYeYJD/yq5HjCwjkUd9J/AhIK84QruK93YKOEqUYc1AULDxgEgcy7rUCyxnWnWJ
 82stuqQhVWsXTWKHBIyizOfGp2A3tm+/UH0A5mc/lhfd/cmDNhrK7HFDgeasAVUjwwZr+Xweb
 /p+mVhDswsFGH4+jSrHtVu3Mrx9SGQlGvLEGnLL5U/wpfEP04tiWVF5Pewucw3fi4ChBTVar5
 bYLi1zImlI/7ZmevIR8zrHPdgcvR/KCHukJ0YLmV1DEcT/st29xcXDXs10EPnz9r6m92jzo36
 7H8lProU5Xl/sc281vYniINMS+PjFSFVJ8Z4HOBGZZjxH96v1EixD0ZBI+LG3PAeVe35Q2zDt
 /An56NGlTIOFeYvqQ+5Q/0foxTIzXaY877P6Yi9PrFKVmu/DEAj8AZj4kPKe7B94uvIvcsn+j
 7oVbFpsAowXxBMsF64MaIis7XnzlUvvyW4AO3EyDQ43IuBNQEvg8Fx6VPmRduQQjXgAIbWB8Q
 UiIGTp2EJtwojnO1yS1cKIc0W+7GhqY6tcp0rb99yMwJnFeauFVh0kf1czx9OTmPK38qTsHjB
 iQDt3ydEtCp4sFcJGl48Y2wXlvf5qSWjfQq4t/X7PtFUHBHHGp4aSUUX91BCzmUsH5LubMJYj
 r4WbEdl1eCrJ0aadzn+beQPkwhKUdY8twWGhXU3mmIp3x/s/h/9c5B8UT5ibIV8ln+S5PVEFC
 ZqNeI1pEgo+TEJge5PkoAwGuFTE3BHo55BdBckt16CgEWP0Jn1Mh9fLlkvd8IYqQ3ZQ0ubK3C
 8x0d+ExfmzGTZyWHmzic63GBuucsCqY+j+h9HbgpFABT+3w/j40oONmXPPB0GS9TtGuel/P71
 G29S2ksMUPhoYWyYfqEQ+sUEJRRlRGy/7SdEbtsJW3/WlkjT5rRqtOqmJp0uTv4YKQ6FASWWl
 eSBHMOhIHLj4yz3d0MQ9rawabHSHApLmFsrzoBqRapYU0VD+6yDtPMuexAWLJIiOB48Mcz34o
 wf5xCRL/KQEugE1uXPz7oFiPegsT7j8Qs8WWuA8k61BwYe1UHlaD21W9WND8n+z2JXfWk1oc1
 Y4V55QOC8L95jWue1QeKqwD09eNAqEF+xirG+YuSvyCOJsLKnm3q1tfRHzpvc/anbVFOv93p6
 W/j7FPAY5YzeAv71PEfZM7Qd3EIVxlpI4ljRP7EXntRtbKu5ptK5FlyEfc7U=
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2019 17:50:17 +0200

Simplify these function implementations by using a known function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/armada_xp_edac.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
index 7f227bdcbc84..096d8de3893e 100644
=2D-- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -286,17 +286,10 @@ static int axp_mc_probe(struct platform_device *pdev=
)
 	struct edac_mc_layer layers[1];
 	const struct of_device_id *id;
 	struct mem_ctl_info *mci;
-	struct resource *r;
 	void __iomem *base;
 	uint32_t config;

-	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		dev_err(&pdev->dev, "Unable to get mem resource\n");
-		return -ENODEV;
-	}
-
-	base =3D devm_ioremap_resource(&pdev->dev, r);
+	base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base)) {
 		dev_err(&pdev->dev, "Unable to map regs\n");
 		return PTR_ERR(base);
@@ -516,15 +509,8 @@ static int aurora_l2_probe(struct platform_device *pd=
ev)
 	const struct of_device_id *id;
 	uint32_t l2x0_aux_ctrl;
 	void __iomem *base;
-	struct resource *r;
-
-	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		dev_err(&pdev->dev, "Unable to get mem resource\n");
-		return -ENODEV;
-	}

-	base =3D devm_ioremap_resource(&pdev->dev, r);
+	base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base)) {
 		dev_err(&pdev->dev, "Unable to map regs\n");
 		return PTR_ERR(base);
=2D-
2.23.0

