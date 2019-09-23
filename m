Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3576BB15C
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2019 11:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407091AbfIWJ0M (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Sep 2019 05:26:12 -0400
Received: from mout.web.de ([212.227.15.4]:36187 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407083AbfIWJ0M (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Sep 2019 05:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569230748;
        bh=rCL1Ykh2uq6C2QvDE/ZLl3K6kFcx8ecC7evEF/aNcuc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CMs8p7+rdu32R1vARqOF62yFX1skqFTi+xt9E7MY0AbLfZxgic1vV3GhVBqY5cvls
         laCVNDVC/jkW744/+zMaBHPjLhhnmFs3yeWY4+O5NFxG/hU/FS3tnRmF453mQlK5ym
         Byygp764T7QIKdtmn3lwE3UXgGIwgtrPpYXSnSZs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.187.72]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MNP6P-1iEoVB1Q2z-0070X8; Mon, 23
 Sep 2019 11:25:48 +0200
Subject: Re: EDAC: Armada XP: Use devm_platform_ioremap_resource() in two
 functions
To:     Robert Richter <rrichter@marvell.com>, linux-edac@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        =?UTF-8?Q?Jan_L=c3=bcbbe?= <jlu@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <3cf2076e-6394-4997-613d-cbf5b6dbee1e@web.de>
 <20190923081117.4p4mwqz35fzavkeg@rric.localdomain>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <65836b6f-9133-4a14-466d-865830f5bfc0@web.de>
Date:   Mon, 23 Sep 2019 11:25:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190923081117.4p4mwqz35fzavkeg@rric.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KI+jcdgb51EpvZ4VWhhTQ1f5IQ01NfiKxB05P3kTDUJd4HE8RNC
 IkhwXxnoqHGRCVcOwXa7yr/uUUhCv6pVOYXRhCfVjyP1p3IRrdfIv3hQ4YI1+/h42+LiMNa
 taNF3IIyRrgLrG4SD0yxfenVpD5F8qXuVi7ottPaKdSGG6jgBPrZbIq1RxBrY6n9ferxww7
 2rHO8bfy4qyxKA34vkpKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ewdcdC3kerI=:V7ksKCLbuT0e1gPmtddnqV
 xF7o64ZS5MK3tUdqrz4WDWLH6lbvbuztdmYx/V51+ruW4AUZ0PMjI82AIOl1YOial/+fDuEKJ
 ccHlm90JNPgfNdBWwmQ2AHYmo6VNE1aUO3hjLwKXkLJmh3ZNyWZ4s2L8OWysfFbH0sDO5P1Og
 IXKK5OR6sjufZwJdiqWq2Fuf4KXIc8ws9RHJMJpQSFesAnTILnrXbitfauSfrT5uuCryq0BEI
 o9JcpS4yHFjz32G/sMVH3m/WxRAbv14Yqpqitkx5fUzQQ/hQMfuhVVS8vDaSTi+WF+ZspJtmf
 Ju399fgDgPGjXYafC3lMvq83Fjiil3nQIA2YrubvaikNWq+dtr4kL2zMFh7u4uCUDw5SItY/i
 JVRSuoqtdxEabxtfrzSvMfqQ1nMVx8dZl/78ckdNGVRql9qyn7LVgDTRROFk9KcI+XQx9Rn4P
 4Y1NPKKe+h3BTDWr4sF3k0MsqkanbsvlwWdqBn2n3Gv+9eojRbtOPwVRSDk28XG0YYsob7IjQ
 czm323pq/XZ+1d9xVumJh9/OAIqKjZWxYbgZ1za00x45TO/omJnbvIiS16Y6cRlACrTyRUK4q
 fyfaIwVNbkxNjQ0dnL2LIEG5GTWYKp5nUwPOJ0+zRLC6cpcpEiHrlEcp8fquEI9HsdscteReP
 N8+pCftBUH+KpLDqy043gPBvablS46XePUrFws0qbTEm/uELCQvK8G4fr5N+q3aKGOh18/ixg
 52UFSw2X3EGPEZZYI55IeWobKoGuIOqpmFIZZtOvXw7mP46xP/YgwJVCTgLYuRBLqy2Vo590p
 l6MA+k+62ZkNizMq9ObxjBRLU0ZmzIzUwdaHw20/yi3fHanJugZREpHelJdKWkWdRVD+qnhZn
 hj+YUufY6uaUHV4W7z27jXm+5GLSvvgRKMrIojrFUxr5XaPdBMo8DXOoHgCVOtYzKnRciHNWo
 IftW6Lbr+fQgATP9lCevrPd9eMfHD6DqPY7Ob8SFmGVyZ/FdZcaM3ef63Y29J4oApSzjxXGUT
 w/E3PHGeuHlRlDq1PNYfzFz5E2yC3fnsAEZx4QFNac7R4W4Mwd6QuWGUmK3NomzRp89tpG2vQ
 DdJPOsjsRmrXgiMO6+1RJTpgBrkpkCEBd3urKB7Xc5V+9qdqVju/eCHvvHKK0XA7HjJ/mDp4l
 kWbjJhX+fu2JLS4zvFLhBvi3nMdImz3yudSS+QPxwQwV/SvyxGEYDZWF5PZWfu0pmYL9k4o4B
 WaRvrpB6efsf5cwdlQOgdt/3YsZxuGYdTfE9h90mJzsTJtFria7Ots4MZjQ8=
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Which semantic patch did you use here?

I suggest to take another look at details around background information
on a subject like =E2=80=9CCoccinelle: api: add devm_platform_ioremap_reso=
urce script=E2=80=9D.
https://lore.kernel.org/r/2cacd712-a8b8-6471-a9b4-23ba54434c02@web.de/
https://systeme.lip6.fr/pipermail/cocci/2019-September/006303.html
https://lkml.org/lkml/2019/9/19/81


> There are probably more drivers to fix than the above and the one you fi=
xed:

Yes, of course.

I concentrated my update suggestions on a specific source code
transformation variant recently.


> So while at it, how about fixing the .cocci patch in scripts/ and run
> it for drivers/edac?

Some developers are trying to improve affected software components further=
.
Did you eventually receive similar patches already by other contributors?


> There should be one patch only for all edac drivers.

Is there consensus for this kind of change expectation?

Regards,
Markus
