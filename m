Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD1CB9F0A
	for <lists+linux-edac@lfdr.de>; Sat, 21 Sep 2019 19:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406216AbfIURDQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 21 Sep 2019 13:03:16 -0400
Received: from mout.web.de ([212.227.17.12]:59193 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406192AbfIURDP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 21 Sep 2019 13:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569085374;
        bh=zQJSoK5O046vNw0Xn8o1QL7Tl7TkCkMseqOpAr0NV20=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=YgeiR8JMJ3VwxfXHlp33Ssyn/IWwy1MEQEWzNvJDbO6BqFxFNvz++EQ1XMTh6T4IN
         q6SrmI6fHIm1e57LS2gUEgEgw61iPtErKnGDpwIMZ8OO4mj5HdcP0jK8gMHEIhpLMH
         o5XYS51BeZEG+smcxXXc8lL/7QVtIA7qRM2EHRDE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.64.44]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmuAa-1hi9Ba0s7I-00h3e0; Sat, 21
 Sep 2019 19:02:54 +0200
To:     linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Shravan Kumar Ramani <sramani@mellanox.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] EDAC: BlueField: Use devm_platform_ioremap_resource() in
 bluefield_edac_mc_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cda92ed6-feb8-87a0-1477-1f784e3dc576@web.de>
Date:   Sat, 21 Sep 2019 19:02:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k4e1oxOdJsiHEJTtoEf3M5AoZG8D3xOl99OQZI086pgCSny64Jn
 wXHlVyg+G+8GMrGlgeXRQMZNF8rL2sistSOPtIuKQb4MEUCq7aFzs7FJYe8HAaJygZvNQAC
 Jq8d6YuKe8UcQl+VYiEFz7fhUJfwdZt4qmyHvNLsuxOSlBE1pifGFHOrVdxO760g4g7HjJi
 01REofvxOGfS2A7KS4wpg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:p9gDb9qbVZg=:xAQJAVdzhWWbIul1i+Tujk
 b703L7FI0XyiKDLfAlvztTmsokZXFFXq3AGg+VGROfXMMPaoJjtT8moXx31wjigahZevuv6TC
 HsrkvuXss9qGQq2tc8CoVXW5lk9dPgfLSRXe6lrFjxqHLTyfmjD+i4nsvrtlZ9bJ+3KcUAXcM
 TX50IGBK7QOApVnfJ/StBl63f9Zz0W661zWzeo84uF65dvYeOLamMxn/+EAkfC9GQ+Es8d78w
 6WxjwBFFZmIQ58vpgk4EzwvQ6Hgs15YyNSGgXHeIkqkSI4vR0+NnofeOm+yoruc/O6hqIdFub
 EWmrKK3Hn4r0GWpKXtIyw+cK0R/RiygaiITR9fuhOpxhjpnmHkZPLXjDhsMG0EKXRbOe5gxeo
 7B/MMeKUO8CTjsEJSpzjKW1sIwmAurXn003LrojMPU9pyEVF5bKjQK4BR2RqNI5nhZg07OuZE
 pHjq9j2A/C8BVKskg0W9AfD78WK3xG3sP3p0pDyXPues3ydmvsfEAxZxbNqCM87Dl+pT6nf7Z
 5mmRCi0Eb/6VvoGLFGQDdsJd1VOVFp5DBT6CbUhMGuWqaeVi1QzBQKzPffASPms1A7q/vANKy
 Ncg0dwUWs+WtIKsNVlumgqbTFdzDcM6xchugfGOZXRvFK4KR/f8fgCkyET6duQ7/xGJy8ag1D
 jZe71pO1oaXcaCRpoKGH0jTtbCpyKfKa/d5ARMxGlpbDFYSDf5SIv+rl7S0IS++sMPcS6e3pm
 qcwL1445N0pgooLEyToaOz1AbLoIWaUCwQsDP6YRwONxk1IAgpKPc24X9Wxr68qfZzlwa+AKp
 EaKOMOcUVknqRdm0crwNyn1cWHObhv389O2XxkPPsGXbKNAeMAOvOG2IwcYySzIiAvyHaO1wL
 icxAbz2hkebFrUwswJ1RLDYjmqYT97FpBVaGuDrAyG6pNxheHOS6PxqLyyZ0k/NN2s+CGBxk4
 nwwUi8DYApA5Lluqe0v61XMeRVG0BEYZsgvC5g7LNvMh5IyHd/oRqQzVkq9aph+MKdeZ0FXMK
 lDY+3F3mWKHYgBhAuv5CyAyZTiF3e/l5JDTpmanvaKYo+mS5+G2sU/TNUoqxeylC2EUgaczyY
 h31tKv5f4m+BMZvOQzeK3g/IaBTE0sA9GT7eb/F3dHw9gQGKJRxUkWZfqFqYlFK9VkUW4cyP6
 PIaTXN1uGMkczlqG93hM/x0etM4ghVKNwiHaEd8wz/uyPiV7NGZKs3Vaw7OHEESfPO5JvHzaC
 dPFe8KB6CgUQKswcv7ut9fYhOYtFboRb2GzpjqPMP+CcPjE6qVdn8vd0/px4=
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2019 18:56:54 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/bluefield_edac.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index e4736eb37bfb..0d09add30460 100644
=2D-- a/drivers/edac/bluefield_edac.c
+++ b/drivers/edac/bluefield_edac.c
@@ -245,7 +245,6 @@ static int bluefield_edac_mc_probe(struct platform_dev=
ice *pdev)
 	struct device *dev =3D &pdev->dev;
 	struct edac_mc_layer layers[1];
 	struct mem_ctl_info *mci;
-	struct resource *emi_res;
 	unsigned int mc_idx, dimm_count;
 	int rc, ret;

@@ -266,10 +265,6 @@ static int bluefield_edac_mc_probe(struct platform_de=
vice *pdev)
 		return -EINVAL;
 	}

-	emi_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!emi_res)
-		return -EINVAL;
-
 	layers[0].type =3D EDAC_MC_LAYER_SLOT;
 	layers[0].size =3D dimm_count;
 	layers[0].is_virt_csrow =3D true;
@@ -281,7 +276,7 @@ static int bluefield_edac_mc_probe(struct platform_dev=
ice *pdev)
 	priv =3D mci->pvt_info;

 	priv->dimm_per_mc =3D dimm_count;
-	priv->emi_base =3D devm_ioremap_resource(dev, emi_res);
+	priv->emi_base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->emi_base)) {
 		dev_err(dev, "failed to map EMI IO resource\n");
 		ret =3D PTR_ERR(priv->emi_base);
=2D-
2.23.0

