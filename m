Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582531E7AC3
	for <lists+linux-edac@lfdr.de>; Fri, 29 May 2020 12:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgE2KlF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 May 2020 06:41:05 -0400
Received: from mout.web.de ([217.72.192.78]:52875 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE2KlE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 29 May 2020 06:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590748824;
        bh=+wAiMDNFio602uNPabgw/r6hz20IhiL6ukS6zVbgxVY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=pLN5QeTo3FCrf4/IS4IDvoWobgm7luKLKu+wxr2RbxKB2EvRFXqQgr661ZAtpRSoN
         xXtc+EhcMx68y3FSFmuSkrf2aF73hUGjqgV2Q+rnQ+NAzsLf7piWkclqEX7GPo9+0B
         tOnS1G/3Bvy7NIr7M75yz1m1KLnoBqaRw8YcGNEA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.165.0]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAvKi-1joToC2qUW-009u3d; Fri, 29
 May 2020 12:40:24 +0200
Subject: Re: edac: Fix reference count leak in
 edac_device_register_sysfs_main_kobj()
To:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Doug Thompson <dougthompson@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>, Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Robert Richter <rrichter@marvell.com>,
        Tony Luck <tony.luck@intel.com>
References: <28ebc99f-c0dd-00b2-7a53-9edf0df36c9c@web.de>
 <20200529093644.GC9011@zn.tnic> <c304a0b0-692a-0696-6750-05a3db6a4b42@web.de>
 <20200529094758.GD9011@zn.tnic>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <fac5fdef-6148-38fb-1149-5bfc06969ac8@web.de>
Date:   Fri, 29 May 2020 12:40:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529094758.GD9011@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:m00H7/5g61GUHTEsuih9HUrppIpBDMeVP4mfZeArkSlTbm9cwX0
 RDxCkuFhVPb0/gUIfXSsWF/vFlNxt+m6VGCoWMmdrlN5H3n9JmUTGpnTZNsJ8FpJIT4U7Mp
 NZbnN4JBKcJXWpNGtBryv79mQmtVN63shS2Q/+Q5JnnXzRvjcWPxpUtSN5On7brCC/NrUZ+
 OgK+3rQ6xXPvVYEp1vuZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dNfjEbEIGD8=:ujD+oHSd1WKaUfiugcPN9Y
 IRynuLjmeYGiVSuPjMq6VjzddpCk6zYxKehDiENzEhOgC2tZzzChlNGs3Dz37heRr3NG96d/q
 3WwhG5bhInS/lM40z7L8usl3ifARcJmqCUyu5FrqJOkrQzATMY59Fx0+4EBpnRL9L213eo9xz
 tvMSKTJ/UpM+Zp9tSnhBphF9wzLkKOWh6E2mf5Ifsy9jmeAGmXLeIHYvRJYqVfKR0YgfWaMlW
 TJ7xMpq+Yyu/lKh2mOkLGQ1SjRdYDhGx2RWCv+afgrm0DtP0+9jtr/tLtji7frGagZZHGarfA
 1K1AzLbdg/R8BzQXF02mh7R0yyUrD4CxfXr61/6N3kD8v2NSrsr+1ImW0odfGjhGE9U5rs99s
 4+GGPS+39jV9KPB01lTUb7o3N1YoaHrHlCOYYv9OvldV0k31Wch2FBemVgTDKMllyXqs/U7KH
 PSdSJ2/zrsD2BymT7K43X/imMaGYOVlPXfyQhcR6vm5uLVc0JNoD0mOIrOSNgte+wObZNx+y4
 PYnmQ/AJA4Fpew6/pQKr1kf2j8ihPhXzyMtlLrHKaNYRyr3VyCWaZVmftty3LiYMBz1FssNZ8
 QIDIIkyPDVXBPajVBq2hXMEaC2BPVvoiYFD6bt8WkpvcJDt4T7udcJvsjXT1lTNchCdSvFily
 5JJ+2gzTrxikZg5MCxzN0YvRnwoELIqt8XpSVwRZCN0q4x0goibrLLhOuZrreevPY29VMSISZ
 ETrdWj/xU1FuNZiQMIMI8y1OszT9ko1OT2NlqPuMY0Pt+t12fzvyzzIYA8LHUV6AKohiUtu2V
 QoeGeviunwgz1eK43VBqx12N+/EVZ3cUhVct9uYm+eUtbxXyUzRbZs+DOxfR1IOxA1wA0L8os
 dsoeeDBh5l1tdsU2Qb4ohWZDTp8Jotm3kk/KbIGgxQYoWltRrqjyPivHYPrsEb2oTWSyqKeh5
 dYKbQzs3oO4k6EZabqbzMp7WGwxH6WvTO1Lk3jwVeRamRFT05YvmamsmTdn/O1psk4pmd9ahM
 l2PO3U9JhgcNjZ3DaUx6Zab/+S9fFH5rEdoOiWr+a4ftjxN5P1SW3Cp7CE5vMiV26a79SKgzQ
 38b3eVJyAjxWKO+bs5TURYKv8cqpu23IXgib/OMYEJFyzZ3xT1/pNGrMfY6NWWHp9bMYUZlKh
 qUoTCWN+fmZG7gdn/Tf1YL+Ix2lsXfgwjUQify3j1UIrOwDDa3O/koG9aaTJDzkbn2iMR2kxW
 fkCaVsGe72f5JEwoG
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> We have me stopping you from giving new submitters wrong review

I do not find my suggestions wrong for this issue.


> and bad advice.

But I can understand that we might occasionally prefer other software development approaches.


> Please refrain from "reviewing" EDAC patches!

Would you prefer to clarify any remaining adjustments from my selection
of change possibilities?
https://lore.kernel.org/linux-edac/3cf2076e-6394-4997-613d-cbf5b6dbee1e@web.de/
https://lore.kernel.org/patchwork/patch/1130412/
https://lkml.org/lkml/2019/9/21/121

Regards,
Markus
