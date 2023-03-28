Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43366CCA95
	for <lists+linux-edac@lfdr.de>; Tue, 28 Mar 2023 21:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjC1T10 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Mar 2023 15:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC1T1Z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 28 Mar 2023 15:27:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3584F2D72;
        Tue, 28 Mar 2023 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1680031599; i=j.neuschaefer@gmx.net;
        bh=GpTAz3PVKqdxb2IFGjJH8mZ47/kFakfrUqF4ZFqc1C8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=S1A17IVqw3ppej2WszO5YvAS1VJZCvbmDpIpfprkturEbdd1T9kUjIY0kP7IwJRt2
         IFN7aWBqOXs0/5S/SxHrRWUEpqpzfKxAI/mRPGpTcJh2GsmD7klc1Z/fisNoz2+YGj
         MRsMUXRed9yoCk4DLRakklrYXKp/qJsRHTlvvZ1WnR9OBwJh1GJ27jB6j0o2GuJInQ
         /lkIavTNlLmQY0An5tTJ2WGAj+NUvZ1gIjAstMBCAQliUhGCI6mKCrwV8wAnGUqmoy
         ueNlhvGezH2w59A4ZvZIeNupLIcOUAKecto827A0fn5uB+3brMZibzbmkFTnLpKWMq
         wM7GpmS04ja7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKm0-1q4vga49cY-00OmM1; Tue, 28
 Mar 2023 21:26:39 +0200
Date:   Tue, 28 Mar 2023 21:26:37 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd81*1: Remove "\n" from MODULE_AUTHOR
Message-ID: <ZCM/bUZqQ+hbvZrG@probook>
References: <20230129165054.1675554-1-j.neuschaefer@gmx.net>
 <20230319192011.GEZBdga+n600nFi/tA@fat_crate.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NijduwC7+Emm27A2"
Content-Disposition: inline
In-Reply-To: <20230319192011.GEZBdga+n600nFi/tA@fat_crate.local>
X-Provags-ID: V03:K1:tDCNtKgoEtXFWvbpEy6+TeWPwsuw/ajsQHTKVPm7Bo4bsn/qVfT
 EEFUizyGQ3X3u9rLDAH8oNM1q2Hd1YcfiRXX1VPf2Wusm5b19SuimPlQO8UVMIuEMCycTO6
 g68mcmK9N3RWooPKOHkM05+wbLYEoyzQhKP9TQPNx7F4tLvIHfjLF8IvQfYeK5U7cxRvuo/
 C3ipyAd2ust+5Xp2GM+tw==
UI-OutboundReport: notjunk:1;M01:P0:BO/FGDFFOAE=;ZQA4nmsrkrTRP8O+uSKOf9F/5CF
 T+fn3jD/o96OqQOmAOXgzakbJbByAxO/p8C8XKhML6AeqJASg8Gs9IZnh/be0JoO5Ri7cC5yX
 YCHi6w184/7pgfUxBvQsgLxpXfz2W5OTU/gn43ald/08jZ3Kn/dJCPjs96RDki2rbhbnVYMZC
 wFsEoeSGVYckS1o/wZeF+o8bzkmHuZYvxXDFAXJZhNhRhffil+eU7XrWSlCwnmm+ubjH1KtxC
 Y8XK7sWgEl8IdgJb7CBU5NyxtCa9LayFx9+nI4n/SLaM/hNR3gVQINdmpyDTG2/WC0hw71ER6
 WGoOOdAwjcZe6FmHG7lGr1wEdI60futQ7et+LAW/QX+XKsLQ1SOZxT0aBzV8mURhy7/wI/zSH
 XARahyVyaaCxxNBmQaQac+8OL5fDLc3et2QvN4N0VuMXtqzOCAjd1iZlHg3x3opKFVc6+O3RC
 ke2yNSraYiZI86sPZf93jq4Y8D9dqwfEisdSlp8Tq6YKTo1q3w2Lw7q9dIX/zdNUF5PqUxceB
 TdtnVWjHPWIm6VnLXqnorS/+E0rjU6ojYhJxnF4HBefjN0HiMPMbSxR89/dtqkR1F+TkRNXT4
 g3hFSpfmNvFqtsZ1dV0QQ/GMQxU8j9kirqb7HZ5okons/fMmlGxQvxiEhNJcWY0CZL0kdhjo2
 KoruHtTBExdPEUtg5P6Kaq7mbolpaW42vFa5PDE9NdhvV5bsMiKYDS2wjEqhgOgnaKUgth/zd
 BQQe3dwNOveBlhYTPf5bXFr5VW6ptfVvQS3qQh53mvtpbAPlOHG8QEaHpiAPJfwX0ZUarfcBY
 jIaQPKsVbfa7U/PtvvUrE7tp1xIWttpDKKPFIBhNW6fCFqrEe5B+otgdRXX3GJBz1Q8e4IN17
 xQ0ARYRAio72Xct65TiBtNsZ1RaHJeDH7rLqOujQfsKn6YW1OQ+8/flwZQNpr4nQ5864LK7cm
 Hnq6T63AOhhkvvX9J4uMH4+jC9k=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


--NijduwC7+Emm27A2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 19, 2023 at 08:20:11PM +0100, Borislav Petkov wrote:
> On Sun, Jan 29, 2023 at 05:50:54PM +0100, Jonathan Neusch=C3=A4fer wrote:
[...]
> Wanna fix the other two in the EDAC tree:
>=20
> drivers/edac/e752x_edac.c:1465:MODULE_AUTHOR("Linux Networx (http://lnxi.=
com) Tom Zimmerman\n");
> drivers/edac/e7xxx_edac.c:599:MODULE_AUTHOR("Linux Networx (http://lnxi.c=
om) Thayne Harbaugh et al\n"
>=20
> ?
>=20
> That macro takes:
>=20
> /*
>  * Author(s), use "Name <email>" or just "Name", for multiple
>  * authors use multiple MODULE_AUTHOR() statements/lines.
>  */
> #define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)
>=20
> and not prose.
>=20
> You can move the prose to the top comment in the respective file, if it
> doesn't contain it yet.
>=20
> Thx.

Sorry for the late reply. I'm replying now because I saw that you
applied the patch.

I might fix the above if/when I get around to it, but there's currently
no guarantee of that.


Best regards,
Jonathan

--NijduwC7+Emm27A2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmQjP0sACgkQCDBEmo7z
X9vtiRAAuEXuauavQAOoTTRGRjGu4a87HjFMk+x8irORL565RuL5jm8jTi6s+wrk
ETyaWP1HYFAoBo/tPcvnVNAaqMCbmmSs/nQxXR+Immxk8c0MtRbcxwRCPQrN9JqN
BH0Q+ojVXxQsVz4+zZmUp55bA5ZgIzaQml+e5Ttj1O/CD4ICzWBtX/WxA4tqSv86
Fowq/2RF++zk0vA2aheOjOlHwJzSm8Ic4rkgC7tWCscvpBG7Ulb8DvAwhD6GzrX2
OdOlXByq6EsdlmQM6Ucm09cplHk5dsXLSoiyq3BI63Rp+aJfiF+EU8mO/DIEuPvA
ReP/dQLvszKNrgIRYFnUFWN63cWMzKt4yxay3ok1e39qw/N8zHB+V3Pu+Sw00t4i
0n5QL4YRC2ntVnYSj6yd25raNsZBoL20wwdd67+ay8HJdo4OIyIGAApEZi6V7yf4
HdYO8qvcngAts7YGmmdpDs42Egqtq/uJ7/+dvyb0OfvJvzROuK0XCNq/dBQOG/Rh
fHwGv6uMJ0rg1Wzmfx8r1Fm/6xv1uMrNr5Li3MItwexnhzg7Gm+svh5s977RQhL+
LouHoSsfH/6RXGbIx8QHCVVL4gP2s6yVXvqQqprWPE002XmKDQvT5Hkfv0hRxSdD
pCqilHrfFP4I7AIOIIrLgS2trPB+40it/EAatji615Dej648RTQ=
=S5Jm
-----END PGP SIGNATURE-----

--NijduwC7+Emm27A2--
