Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA221E7935
	for <lists+linux-edac@lfdr.de>; Fri, 29 May 2020 11:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgE2JVW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 May 2020 05:21:22 -0400
Received: from mout.web.de ([212.227.17.11]:46043 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgE2JVT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 29 May 2020 05:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590744045;
        bh=Kd4etKGpgDbxaOcHb8L0zTOyqoQi6t3/zIyj8EQhQo0=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=YCO13Ittqm9AzvKmQAQpHyfBRzXnKQCqHEl9bHy+TtLve5VjqdXvRznOJLyyGtbOP
         fcgGvZjVwCFLiK4UkiWbrmrrdresQc56iAcB31svEl+oTMqWKR8TYH/WJq2xxo60cP
         EWw/Xq8Z4SK4+op0vysww+oAAaD3XiAJ1RiKrSrE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.165.0]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MS290-1jYWMI351m-00T9WR; Fri, 29
 May 2020 11:20:44 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Doug Thompson <dougthompson@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>, Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] edac: Fix reference count leak in
 edac_device_register_sysfs_main_kobj()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Qiushi Wu <wu000273@umn.edu>, linux-edac@vger.kernel.org
Message-ID: <28ebc99f-c0dd-00b2-7a53-9edf0df36c9c@web.de>
Date:   Fri, 29 May 2020 11:20:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wc4h/vv8Qx4sWnVjTAjugQE0U6SSwffpo2MkeG03uq/DvVZ+jho
 MAT0PLcORvTVV8I7ykV9VJNMnBuHSisrKb/4UCN23xQwx7TChAPAQr4gn54qHHn79/dG9iy
 e9rjcvAMEKqh0/1swP5gyN/hKmWLtirZURHzW2YSIGnJJP9MTqFUkBzK+EFhaAfQ9PA8JD2
 LTXBoQoJnR3Q3AHMtJQVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NaWA9wiVHEM=:JffgnmXFNXFBtrY1kNNF9X
 ursDz6UMecwAd/9gwRPpNfewDcl5XS3EtxfeP/R0dd9HHQjgrX3yBt0PLEmu5qyDLVnjPuKnR
 z4TXWKbrN0bK5oRnpGPIWyvHvDZEOiHU+96eSwzwySOczjE7LBtxm2GtPlWyJKZVuu4dfKCvs
 f4EYEa2VuxfOuHJ/3vpAgB+T3aoVbFTv2YB73UOgwUxDhJIFOk3WphBVQps7MGCmFetdnkbfP
 QbpqX6Bc0Pvb4W6ujBAjUXjo3U9UMmQZmHehVE4VPZ+Wes6UnbQbKeYaXYsohFGHIIdApurUu
 GyQVFFSHcBXsgSpGp49SaN5g6ARcIax9fUm0QE2L6t7BLgBei5b/XEiag/HJktFH1rrVlrVXe
 rB62ivnnzHWVBl2ZMJFQi54j2mYy3ht4Vei7YeVq0N/sx/7Gss7tygJaJS45BG5sRsj6ALcNg
 SwpDHpi74kuBB4dgRYLpA8e2cogRxhBC0aVO2LHsjwfoPp4eIj2u4IFDrTMlxl2a4g/n5BRd1
 PgrJwoGh0LzjpIu2AtqWABs5nONACvWZYdpq5TEK+JjbwVf7SPVlSSY53ocERlQ2oUXbR/l/e
 B9vVdDK9oX4ekhyqUxTPctHjaP9fQ7rxFY5k6dxIY8vJ2OvdBZ/ZtEpb0sqp4kxUMX9ms/JtZ
 YCgXlIFf6xGRyUhGUW0WrA3rITFu6cfYgRLguzx3uPKBaaYP6Q6Sc2WGmbOq0S22iuba+FU07
 eOGmOzpDKJe4O8hYNuMj9EneOlNiZ0gePat+sFdDvnvNL5PNmSRf71tYEGaX6AukxLJUxp2QV
 DZ2rd7tZCzc8NORHV9QVDeTIy4Q2iwg2fz+ss7bbxJIZHXDHH3WI6E3CeQkPAyB82T7zSEgJL
 H9lIe/24WwQ5oSu6bwJLqfytPbBMO6g5NOn+Ovu0zBDYcbJW+0I5Hv4mEjh/IjFkajILmCpNY
 402LzrZ75/HRD2YLCKSq4nVVQPPI584tf4O2puojbKRUgTzaFtWNRMO5AviMuzSg50qzzaQUY
 wvf0IHckCz7qjtiF7w+akGbPQGJYtg01AM2b9NTJxgyDFmSa9gk9Lg61ov718KgYpjstH8xjN
 GUDb6rzjLi/1FW41t67y7RtOXAPqmrHFgKF92+QX8VTiPI+iojNJZKtRUekW/kfX0xCC/rMZR
 HLje+Goq4/vUil/NtEcSFOSojgBRR3VZ3tfX6pA2S486gh2or33yInRbeQFAC2STK0R0GbUwO
 2qrQLpLYeUHxBD8+n
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

=E2=80=A6
> +++ b/drivers/edac/edac_device_sysfs.c
> @@ -275,6 +275,7 @@ int edac_device_register_sysfs_main_kobj(struct edac=
_device_ctl_info *edac_dev)
>
>  	/* Error exit stack */
>  err_kobj_reg:
> +	kobject_put(&edac_dev->kobj);
>  	module_put(edac_dev->owner);
>
>  err_out:

I suggest to modify the affected source code in a different way.

* The label =E2=80=9Cerr_out=E2=80=9D can be replaced by direct return sta=
tement,
  can't it?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/coding-style.rst?id=3D75caf310d16cc5e2f851c048cd597f=
5437013368#n456

* I interpret the function implementation in the way
  that that there is only one if branch where clean-up of
  system resources is needed.
  Thus I would prefer to specify corresponding complete exception handling
  directly at this place (instead of using the goto statement).

Regards,
Markus
