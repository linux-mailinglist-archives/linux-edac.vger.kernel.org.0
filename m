Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D8F584523
	for <lists+linux-edac@lfdr.de>; Thu, 28 Jul 2022 19:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiG1Rez (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Jul 2022 13:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiG1Rex (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 28 Jul 2022 13:34:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2250B6FA29;
        Thu, 28 Jul 2022 10:34:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i8so3144573wro.11;
        Thu, 28 Jul 2022 10:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XZ4zIVvfcCsidkeWaZTdSTzaHcuDeTcNOjLwNCugDn8=;
        b=gTHGJkgG1gude+JyHmX79TwGE73T2WZ9MFmNcKNHi30BzronT1LCyMcUDr/MqkoI5W
         l04zpUFC92TcohG3T8lTEOUoIfo+qifgK8EtwRAme3upF5EmGtikt4Llltdtj9koqqt+
         cp6otSuWw7/pJ4b6rz3Zpvckkm78stmSt2L3sORIM/YjuOPA9xdjcCbMhSDQ1qi6Gv6d
         6oMQlGM/RzcHoEwB5FJ7xN9fz7Vrgfs05PvMkPWyynkrriEA/OdNY2DCpcpBD2S0r9iL
         3MMjOtQZ3pF8VQP/8iRPpfpNF9H1eUTu9/ANn0rE4Mb7l5yTxX2dMF1Jb9E86as498rM
         +KBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZ4zIVvfcCsidkeWaZTdSTzaHcuDeTcNOjLwNCugDn8=;
        b=f1ZzynZwS3OFda7yijKK3B+wcF+3q8WmfropHGYDnqy61K0oqKTKTwzBK3c+CSznh5
         XJ2V9iGv3Itpj/o46cSy5vmebcIP4USXYTIi6MSXtJ3SaQDygV0i64El/fhHw2+vgi66
         jAkks6tNQ8C+3IBqZMz07Dcck9upJrQX0WliDHfLCJUc2W4icvVUW9AW3EtKqwRcUdGH
         lVgVsIFzdeLXQk6ZrIf0AHYnDd+Z8FdHpkIdptVq0Rpr4WYoHl0bgCH6xTYPSoZkaHXU
         O3M8/teeIqOoGouJ9PgPMhd2j2YOnEVBb5R96L6D6f7P+mQa+yM49EfjqwDs26cI2IDQ
         LA7Q==
X-Gm-Message-State: ACgBeo38SUCTO4qAIFrSHSnATGGRnMTvCPU+KJ3nFMdY0hdYeg/BR4Kp
        L7Q5kvOI7a008xGyoPzIWUEybrQNpk0=
X-Google-Smtp-Source: AA6agR7/84BmZcJNcafcDcy5qOLjcy7UeHN75LEvTL+0j34k59OqIlFN5YLWf2olSxSoRNl7Q51BiQ==
X-Received: by 2002:adf:d4c2:0:b0:21e:ddf3:8b14 with SMTP id w2-20020adfd4c2000000b0021eddf38b14mr6866wrk.355.1659029690542;
        Thu, 28 Jul 2022 10:34:50 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id j20-20020a5d6e54000000b0021e5e5cd3a8sm1548650wrz.87.2022.07.28.10.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:34:49 -0700 (PDT)
Date:   Thu, 28 Jul 2022 19:34:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sumit Gupta <sumitg@nvidia.com>, Borislav Petkov <bp@alien8.de>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, bbasu@nvidia.com,
        Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [GIT PULL 1/7] soc/tegra: Changes for v5.20-rc1
Message-ID: <YuLItw2p9k4TgoH2@orome>
References: <20220708185608.676474-1-thierry.reding@gmail.com>
 <20220708185608.676474-2-thierry.reding@gmail.com>
 <CAK8P3a1bKUr77t9xkNAX=-RqzRme6Hymr3V=36MSHT_sOFEW5A@mail.gmail.com>
 <Ys6lXD6BSxjH02mW@orome>
 <CAK8P3a0cSq47B=acZ854TVu=RckJNfyfKdqQUMzCX7SsV7Wt0g@mail.gmail.com>
 <YtAajDYfcVHRGl1U@nazgul.tnic>
 <8dd2310d-cf1d-600e-0bd3-7b16c7b4ac18@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Boa0tNoBXKDLUKH"
Content-Disposition: inline
In-Reply-To: <8dd2310d-cf1d-600e-0bd3-7b16c7b4ac18@nvidia.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


--4Boa0tNoBXKDLUKH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 15, 2022 at 01:36:16PM +0530, Sumit Gupta wrote:
> Hi Arnd, Boris,
>=20
> Thank you for your inputs.
>=20
> > > I think this is just a reflection of what other hardware can do:
> > > most machines only detect memory errors, but the EDAC subsystem
> > > can work with any type in principle. There are also a lot of
> > > conditions elsewhere that can be detected but not corrected.
> >=20
> > Just a couple of thoughts from looking at this:
> >=20
> > So the EDAC thing reports *hardware* errors by using the RAS
> > capabilities built into an IP block. So it started with memory
> > controllers but it is getting extended to other blocks. AMD are looking
> > at how to integrate GPU hw errors reporting into it, for example.
> >=20
> > Looking at that CBB thing, it looks like it is supposed to report not
> > so much hardware errors but operational errors. Some of the hw errors
> > reported by RAS hw are also operation-related but not the majority.
> >=20
>=20
> CBB driver reports errors due to bad MMIO accesses within software.
> The vast majority of the CBB errors tend to be programming errors in sett=
ing
> up address windows leading to decode errors.
>=20
> > Then, EDAC has this counters exposed in:
> >=20
> > $ grep -r . /sys/devices/system/edac/
> > /sys/devices/system/edac/power/runtime_active_time:0
> > /sys/devices/system/edac/power/runtime_status:unsupported
> > /sys/devices/system/edac/power/runtime_suspended_time:0
> > /sys/devices/system/edac/power/control:auto
> > /sys/devices/system/edac/pci/edac_pci_log_pe:1
> > /sys/devices/system/edac/pci/pci0/pe_count:0
> > /sys/devices/system/edac/pci/pci0/npe_count:0
> > /sys/devices/system/edac/pci/pci_parity_count:0
> > /sys/devices/system/edac/pci/pci_nonparity_count:0
> > /sys/devices/system/edac/pci/edac_pci_log_npe:1
> > /sys/devices/system/edac/pci/edac_pci_panic_on_pe:0
> > /sys/devices/system/edac/pci/check_pci_errors:0
> > /sys/devices/system/edac/mc/power/runtime_active_time:0
> > /sys/devices/system/edac/mc/power/runtime_status:unsupported
> > ...
> >=20
> > with the respective hierarchy: memory controllers, PCI errors, etc.
> >=20
> > So the main question is, does it make sense for you to fit this into the
> > EDAC hierarchy and what would even be the advantage of making it part of
> > EDAC?
> >=20
>=20
> I also think this doesn't seem to fit with the errors reported by EDAC wh=
ich
> are mainly hardware errors as Boris explained.
> Please share your thoughts and if we can merge the patches as it is.

Arnd,

any more thoughts on this? Looks like there is no consensus on where
this should go. If it's okay for this to go in via ARM SoC after all,
I could prepare another pull request including only the CBB changes
along with some of the reference count fixes. I could possibly also
rework the DMADEVICES dependency patch as discussed, or we could defer
it if it's too risky at this point.

Thierry

--4Boa0tNoBXKDLUKH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLiyLcACgkQ3SOs138+
s6FTbhAAo04Ge2JStIVBs0J6WC1LlVc7vETptyeF5ISXjOh8JFDuqQgmrTOW+iLD
hgw4V4ID1B8Y0LJzKJoWOHus9eXqLWvo4oWVeAjZ5foCYoh4hEmiP3n+iKxqJyyD
CLOa/nlDeQrGWU+X46hN2pTRF5GyBQlhySviRd7Ub/VpeBrRjD7Tngz1vUXt8Qpw
UKxhKZCYcPYu+509DJFRbBM5clzW1gS1wEEmdrUaHuRcxl/jbIZtWE5uR58R/4e6
/mlFXWE9p5dcNmNkKbFNXNV5HtBAuo3wyNqMqXRdQrIuhh0Jqb4zxF2EmlEeJMhI
bqpbRPqQGYVM0TgW9Jq15JOw4raTj5tIw+yEUWd39f9m67ohqsYjOTZdsU+tvLOU
N7Zq3tMl5eGQSttzxO149bfmKMsnL7PUy/QfjDfZ0MXkv4QliQMZXWF3B3izb0xu
B0Y6MVrVNSm6xWk0vU0nhFDq7FigXPLCWfUXSOGNpLNNXjGPcmIw4qwdL09QGJHy
bNm9a8dmSVvurgYWwvsreWd/BlLNhiU/8+KC3MFFIr9K0dC8NRraUL0qSeKsjEGf
Tb90vgsCLtnJ9hSKzkCjA3SI4jk/ShwiW8Bbrak86EzhbyqEosEkyAaO2KZBeqG4
oXdAP76UtXa7BP/C9a3fRxAlTbjdeuwpaMY6+sD9/OlsURNLLOo=
=tTDm
-----END PGP SIGNATURE-----

--4Boa0tNoBXKDLUKH--
