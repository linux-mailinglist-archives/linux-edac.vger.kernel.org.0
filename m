Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBD15EC8D0
	for <lists+linux-edac@lfdr.de>; Tue, 27 Sep 2022 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiI0QA0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Sep 2022 12:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiI0QAZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 27 Sep 2022 12:00:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D959B75CFF;
        Tue, 27 Sep 2022 09:00:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e18so13852865edj.3;
        Tue, 27 Sep 2022 09:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=aJuVRn2ynJ1wXVYFYmSjthXIebM45gjx5lMxq4i3RYU=;
        b=nLdsiPS0LfTl0r4gKIVJQw3DFA6Qymnb+9UxbtB7/hFgQTrRV6WuOGZmsNQ5pkN0Qq
         lU1TWVrdLl8TbgEY2EBVTrgRQpzp3czCcdBJO+uXk81oovA0vrk1bUOfd4VJOWyZ73Nd
         +fdcxik/Ae2eRONez+34XbxLFOYMdt5B50bhZggBcmJWBztRARNz3U6NqiY84uVmz+iB
         1LN9YZfU6iHgwvKMM2qGKSry2fb6d0PEc5QlqTW7IY5XNsWMqcq/sQCKVmII6GCImUHw
         2THSZIfDoYp4RAFpocaWNf5/fkfncr3FpKThfrual81nTw9cNOMVSNY1B+P7xOj58yUh
         EHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aJuVRn2ynJ1wXVYFYmSjthXIebM45gjx5lMxq4i3RYU=;
        b=8AqkXJQZ5huDtxs2/69GyyMkh1HQqWIXVqytvaBMW5foo45rNjw2pcEdh12QgILHQD
         X5Z9YpwpxRLzzj1P/PSJm8nK9vDyT80BPHir2nij7aqvj35Kf/EsoVoXB9+xAfdZmXKf
         kew0qe411PMC3wToM1QqkvrICi288o3VATywrq6PGKb2GSR3K+3uwWNvAXdJDpYypF90
         vwmXx2gSlqgIAK9wq5UNxcrFJ+YGtRhlic7tZPsACN8IsYuKhe0OUgLlXVlJ4ynuGuV4
         7ji8XF7eTP+nc67LdEyeDEZN6YebJRIMAc/O1f8GqkCe0stP9stGVsC8afyyooHHiU69
         j7Iw==
X-Gm-Message-State: ACrzQf0EtSk8SZp42mNj+a2SDyCPSgerfRbk1cEd1+ve8PV2LssZldsM
        brV/D4/fGGH0VXJSyA+ODMw=
X-Google-Smtp-Source: AMsMyM5yL2bZzFqp/CZGyeLzDMFRkqmHp3vo2ulfm1un/c9MP9lSWKMrVthKTc+9rpj3zqjzijDGsw==
X-Received: by 2002:aa7:dd57:0:b0:453:2d35:70bb with SMTP id o23-20020aa7dd57000000b004532d3570bbmr29223064edw.26.1664294422229;
        Tue, 27 Sep 2022 09:00:22 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ku18-20020a170907789200b0073100dfa7b0sm1013854ejc.8.2022.09.27.09.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:00:20 -0700 (PDT)
Date:   Tue, 27 Sep 2022 18:00:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org, soc@kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Rahul Bedarkar <rabedarkar@nvidia.com>
Subject: Re: [GIT PULL 1/7] soc/tegra: Changes for v5.20-rc1
Message-ID: <YzMeE2HKOd5WaNqd@orome>
References: <20220708185608.676474-1-thierry.reding@gmail.com>
 <20220708185608.676474-2-thierry.reding@gmail.com>
 <CAK8P3a1bKUr77t9xkNAX=-RqzRme6Hymr3V=36MSHT_sOFEW5A@mail.gmail.com>
 <Ys6lXD6BSxjH02mW@orome>
 <CAK8P3a0cSq47B=acZ854TVu=RckJNfyfKdqQUMzCX7SsV7Wt0g@mail.gmail.com>
 <YtAajDYfcVHRGl1U@nazgul.tnic>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XRzEosQ5RA2jqi3s"
Content-Disposition: inline
In-Reply-To: <YtAajDYfcVHRGl1U@nazgul.tnic>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


--XRzEosQ5RA2jqi3s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 14, 2022 at 03:31:07PM +0200, Borislav Petkov wrote:
> On Wed, Jul 13, 2022 at 02:14:27PM +0200, Arnd Bergmann wrote:
> > I think this is just a reflection of what other hardware can do:
> > most machines only detect memory errors, but the EDAC subsystem
> > can work with any type in principle. There are also a lot of
> > conditions elsewhere that can be detected but not corrected.
>=20
> Just a couple of thoughts from looking at this:
>=20
> So the EDAC thing reports *hardware* errors by using the RAS
> capabilities built into an IP block. So it started with memory
> controllers but it is getting extended to other blocks. AMD are looking
> at how to integrate GPU hw errors reporting into it, for example.
>=20
> Looking at that CBB thing, it looks like it is supposed to report not
> so much hardware errors but operational errors. Some of the hw errors
> reported by RAS hw are also operation-related but not the majority.
>=20
> Then, EDAC has this counters exposed in:
>=20
> $ grep -r . /sys/devices/system/edac/
> /sys/devices/system/edac/power/runtime_active_time:0
> /sys/devices/system/edac/power/runtime_status:unsupported
> /sys/devices/system/edac/power/runtime_suspended_time:0
> /sys/devices/system/edac/power/control:auto
> /sys/devices/system/edac/pci/edac_pci_log_pe:1
> /sys/devices/system/edac/pci/pci0/pe_count:0
> /sys/devices/system/edac/pci/pci0/npe_count:0
> /sys/devices/system/edac/pci/pci_parity_count:0
> /sys/devices/system/edac/pci/pci_nonparity_count:0
> /sys/devices/system/edac/pci/edac_pci_log_npe:1
> /sys/devices/system/edac/pci/edac_pci_panic_on_pe:0
> /sys/devices/system/edac/pci/check_pci_errors:0
> /sys/devices/system/edac/mc/power/runtime_active_time:0
> /sys/devices/system/edac/mc/power/runtime_status:unsupported
> ...
>=20
> with the respective hierarchy: memory controllers, PCI errors, etc.
>=20
> So the main question is, does it make sense for you to fit this into the
> EDAC hierarchy and what would even be the advantage of making it part of
> EDAC?

Closing the loop on this: we've decided to keep this in drivers/soc for
now, with the option of re-evaluating when we encounter similar
functionality on other hardware.

I'm also going to hijack the thread because something else came up
recently that fits the audience here and it's up the same alley: on
Tegra234 a mechanism, called FSI (Functional Safety Island), exists
to report failures to an external MCU that's monitoring the system.

Special hardware exists in the SoC that can send these errors to the
MCU via different transports, and the idea is to report software-
detected failures from kernel drivers such as I2C or PCI via this
mechanism, so appropriate action can be taken. So essentially we're
looking at adding some new API, preferably something generic, to these
bus drivers along with "provider" drivers that get notified of these
reports so that they can be forwarded to the FSI (and then the MCU).

This again doesn't seem to be a great fit for EDAC as it is today, but
I can also not find anything better looking around the kernel. So I'm
wondering if this is something that others have encountered and might
have solved already and I just haven't found it, or if this is something
that would be worth creating a new subsystem for. Or perhaps this could
be integrated into EDAC somehow? I'm a bit reluctant to add yet another
custom infrastructure for this, given that it's functionality that
likely exists in other SoCs as well.

Any thoughts on this?

Thierry

--XRzEosQ5RA2jqi3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMzHhAACgkQ3SOs138+
s6G4wxAAnW+S0l13pKsw2U4zZ5sNcYSoEgHdCR8jCxsO0W4Lc3b8L/xQkfxIleZW
9/6fKDe6sygRujnqnYgBGIUUC6SjgklTDMpQaI39oFK6XglyFsFaYVyZpKBfFISc
UbVFT71QClax5nUbOXmftPPMSHp7OUQzql3ANq2gT5r9usHIqtE3cDamJv1p/CRA
TMPQSakOv9cI+CtQHWPMV7b9DUG9e6SNzsHhpC/JZsbySATcsTW0IyTBY2pNTBf7
Rqe/uCh8jlJx42rCuY/GVGl0TGDO/Im1GjrII5M3OoSkb1aTH0VaSCa4KQhi5WRS
Jh2tnMCkKwwmjpuuNnUc2K6+OUHl2Iya2Gfa+Q0OVhTvi+stpjImpG5xjLpyBj3W
KHFdE1tzXSn1yxwYhe7WS1vd4ZsHWeP19oo6VRFsav+51e1qyXsj2I7PoucD67bG
o+NjiVIZxNg/lnaf2za/6qZ7qMT9kJAXDeH4oUmYhDsydnpLvQZ6aPkDl3X11qaK
BejA3/XatDIk/hL8sqFiVTvgyiqaZJzaVYdEGrr0yJRpuDVCXkCHrG9njyLOYtdH
LQ2aTmFIgunI+r2tDLoEjR8bjxEvV+C9kwhRVAySSYC9Pdwz+Dnb2yWE6AYt8EnR
ZV3aVTGFyjc5OByFB3KBIptfB/syLfnnq9ZcKcWfQvDyI2EMS8E=
=UI0x
-----END PGP SIGNATURE-----

--XRzEosQ5RA2jqi3s--
