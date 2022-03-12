Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149984D6C0C
	for <lists+linux-edac@lfdr.de>; Sat, 12 Mar 2022 03:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiCLCda (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Mar 2022 21:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCLCda (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Mar 2022 21:33:30 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946CB23587E;
        Fri, 11 Mar 2022 18:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647052312;
        bh=5eSC1l7eqOmp/RGVxZsX2fHh5CD2dPBl7+FQDjhPNwY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jmQ0vYxAU4EbuGHiMWI+sDie8ZdkhIpsCsBtdoJGgtbXldxTXHp9y7WpqzV1N0lXM
         79JSWsGHN8YYtowe4xaO+lH6Pk/xrVLIqtezc5dBNfoayBceFcKdxsJi+ldbeZ17+i
         /6UJQkvwxvIgReoYxTjNsVyp9np731fWhqAXl4uo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgesQ-1o3Jsy2ree-00h6CW; Sat, 12
 Mar 2022 03:31:52 +0100
Date:   Sat, 12 Mar 2022 03:31:50 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Medad CChien <medadyoung@gmail.com>
Cc:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ARM: dts: nuvoton: Add new device node
Message-ID: <YiwGFmbXw0qwM9mx@latitude>
References: <20220311014245.4612-1-ctcchien@nuvoton.com>
 <20220311014245.4612-2-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FIzz0YxES7CqLYrk"
Content-Disposition: inline
In-Reply-To: <20220311014245.4612-2-ctcchien@nuvoton.com>
X-Provags-ID: V03:K1:0VEKzgtkOFpmn95wF8nENgQ+gIM2XZXAcsCKzNrwu3AdMU8IA1D
 DgVt2/adhS1P55mNK7/lk0ogmnx6SEUEr8StWCoKh19JvV+vYd1XGCCpbeAwgTmaF7wNeLR
 h14Pk07XydhHx4m4r6IEB0erNFjnvdElsjfurK4PHi/qnLmOgdKrTQa0xwES87fJQdiqPCt
 RTVpr7Yy+QoxWd2igHMIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YEr5uBftH8g=:ySwIA9/eljhW2crjuRcKXO
 D8KeGtsMbtsbWhulrvh2R/oVMMVaskQ4WBpWxu5/HGQwbR5aOQV+0WUdoXyQpDiiL6OpQKeR2
 uk45OqnUhK3+6JHZbImvYv5HjiFZ7OpYc4Pb3kGBPMl+K13/WiNlPqJ76FlY9iTz1P8hmFFy1
 lw0+fo/zjsu1kuyWmbFfOVxnLCMNWwSzenSNNfexSlCHTHfz2jxT/+zFx+aSu9gMBAOm3reAV
 PA8wLc8QjtUwM0zU3eXPUa1q4bxQzFXG7RZ30f43e/QQsu3rbfYAtbGml4APOpT8xEloRsGIY
 oBIwx9NL102zeLavdwWLTmsUupt61AOOY+tzF+8AmCVX6jBff3kQ0wB6NNPlwE3paXHyPdt12
 PZUXED+ImJQh14QJpPD+f9kgvfmZtqzqBuW7JW/FEk7Dx9/LoehKPml6BKW7Y+jamtdyvBMxA
 x3GmLMmvJMLGlJ2kpIPQh3KQR8tmjGWD5tNgpE8aJYXHPqH9eECNBAsScQYumpOVr2xEYz0Sr
 ExKH0VE4K8vOzFSN2DjSvpxdfJTpq7GKlVDqu9MM0Mr+nHK4hfHpObLJ4CcraISlXybM3R6+8
 HNU5CQrshSlaAGASV2rWwyTiFtl10yxfSRNzD7qQXGTDWUrUCRJjBM/2skDY+fxuDqmd7+SsL
 cxdAnUceRrTmuN1n7xBV1s0KP07GhNwN97TI+XvWUQu8nrDJ5MGTIvLYDEYhOhzrhemqRgfzH
 TYIjH9Yw42NfO1M3W6SszI+GRFP0aoMhtx6EX1ZNxlkjJYaWkNOQxWXpy6apvzDK/drmX+Wjz
 Z5ZHjJ2GESXytRk6hlfp0qfEZLagZpISikaT0FsJZQvWubaIxexKppKR5wT7kl6nP6vo5Vm12
 rD2VB9XIS3TrYZJHYrKi6MD9hBlVBI7ILJ85dGToI5Kuk1unLXXqOY13RpqjRXotM6v3a1Izk
 CLj0uQ8/53rNcHoImv+vIXonwiJGgMjeTgUap0X6hQyvtNCKORgG6AfTmQzEsVOTIDL8JqgZi
 epcybsmx2vsIuoi0T3migXTI9R7iLdmCLsa/lWLLzHi4xbxqe8nux2+umqmnKWl+j1MSg3Prx
 SMyvwzah/7ntkU=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


--FIzz0YxES7CqLYrk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>Subject: [PATCH v3 1/3] ARM: dts: nuvoton: Add new device node

To make it more obvious what this patch is about, I suggest something like:

[PATCH v3 1/3] ARM: dts: nuvoton: Add memory controller node


This arguably makes the next line in the commit message redundant,
but there is other useful information that can be added there, if you
like, such as how the kernel is going to use the memory controller.


Best regards,
Jonathan

On Fri, Mar 11, 2022 at 09:42:43AM +0800, Medad CChien wrote:
>  Add NPCM memory controller device node
>=20
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> ---
>  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boo=
t/dts/nuvoton-common-npcm7xx.dtsi
> index 3696980a3da1..ba542b26941e 100644
> --- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> +++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> @@ -106,6 +106,13 @@
>  		interrupt-parent =3D <&gic>;
>  		ranges;
> =20
> +		mc: memory-controller@f0824000 {
> +			compatible =3D "nuvoton,npcm750-memory-controller";
> +			reg =3D <0x0 0xf0824000 0x0 0x1000>;
> +			interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disabled";
> +		};
> +
>  		rstc: rstc@f0801000 {
>  			compatible =3D "nuvoton,npcm750-reset";
>  			reg =3D <0xf0801000 0x70>;
> --=20
> 2.17.1
>=20

--FIzz0YxES7CqLYrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmIsBfUACgkQCDBEmo7z
X9uJQQ//ZX+86tSVuAQB9lcNV0McYuTwib6HMJU73iGwJ1mSfBHgGhLzXLnBwuOh
NdgY0u+jY3XDtLLQoyScem9fpi8ATiN0KS5tmior1pFzJnz9h3vdHp0psNhzK9B3
OWCzsjB7ns8IzigFOBcnhvLA2SnK9Hyf1opvw9E6agN//7m9DnBgOgDONi+48SUb
WJsvi98snOcD/rquB2ezHd00TVC2nTHCp+9wX4XEvVDY+XdTgAk/3BbxQlfQlIqX
K8M+nPYtfEqHJg/eBjNOxxF1x6ubQ9kPXozwiiNksq9VNRgN/foGsjwVDt9g0Ns5
aERMFCm2lAhJmj+CdVvxkx6vhmskk/ybv+pDdCxz6+PK6BE477Kd8YOwHQnvVSvr
s2HGklJ+kieVj/2C3AgCpH/t5GDFKGCqEi8kmVw+fPZ79iWrv7J6ul5hoBvDD4WG
qdiAYMyz69gMAmddMnyx4cCAXScQA6EbPM2ep+seiJDGz4+VvfhyDoPKr23DohOv
+bmMhvK0LoCQI1BwsWVaD6J694+RKsKiQpDsqkjg1md+ER1lkag65ACwfgINFJuz
2aZ28l3SOzNUqt7H75IEfaC2ZE5vVOTbgDlKgQeP8rd9Jzg2crWZyd5KV2YBfNP6
3pL7UQFUBWZf0r0rw1qs5Usm1zyx25t3WgKpD9qvQPxlTq+C6Cw=
=5Gab
-----END PGP SIGNATURE-----

--FIzz0YxES7CqLYrk--
