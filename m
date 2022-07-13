Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3E4573DB9
	for <lists+linux-edac@lfdr.de>; Wed, 13 Jul 2022 22:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbiGMUWh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Jul 2022 16:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiGMUWg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Jul 2022 16:22:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F25A30F55;
        Wed, 13 Jul 2022 13:22:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id e28so17359010lfj.4;
        Wed, 13 Jul 2022 13:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kad+2F/qOnEja9x9urodQ72slIA0xL+DsH57r9iMqHk=;
        b=QPXfmLesTeZYlY0LFVPzsUXMyP4ZuWMNxmGXRx27TP6t+7lHaQdvp0bruogsbD3Hpb
         KCLAwWVzOCq1alX4eqT59aVhJoKAb6+J84Opr80ECDBT/McAMw58caWJgjw8iXBUtMv5
         FL5i2XKXJ96SJdMEtl0VmQTp/fOjwrV6RYni+PAH4+MNMQhViyj4SBchJXw88NlvktJQ
         SqRNrWl2c0vgrXVONEpAmWCXdLHQnIazWc59w3wot15OW1op+z4FxrWRDQno0lPkjCVe
         p1y26EQ8NItK5rS8dNw6/OTlwzxCFgKk63/cebXCew9P1qrwmlhERisbNJO63j0RLWmA
         uR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kad+2F/qOnEja9x9urodQ72slIA0xL+DsH57r9iMqHk=;
        b=B6HxHoLusyjmRoIK+Jhflo2uhLQo/v8cctrnr/m2J/lSm/PbFf4REbZt3a9wrzOJzu
         JJN3qLorWnwL8qImfs23nT1f49ua/SRk4ZtBFwXQTjIiuVxgXjTWOfZyvz2YXVs3KM/6
         tJfEVauyBXYU/vkLEiDEePjTJQgABpJvOtoi0pAz6mY9MUrdqSIqRiJTh3k8fDyAo0v5
         UB779qLeJjXvpVM6whw+U/cBAnlz6VMgP5cqMhz5nx9FScUidz/rc3gZrENNO5v1uPy/
         1C/UPYZ4IKvzr8RdTZN/q28mPy7wf9TaguwnDSlxFFmj1sT68CIeLZVfguJtk+jD6qDk
         yOuQ==
X-Gm-Message-State: AJIora8vwkEIlRIfQSkYCH66jPTKTOBHbLyjjRGfwBUNS44WIThLYdAD
        5+M6vUpj6QfLnp5QB+SgrVo=
X-Google-Smtp-Source: AGRyM1slIss66cno8XTtLBuI7wyPsR26Cr7ChoMNht1n8fCOtdZ0JZRtNLEZUGXFk9Xx8d5WwtRFHw==
X-Received: by 2002:a05:6512:1698:b0:47f:b5a6:6870 with SMTP id bu24-20020a056512169800b0047fb5a66870mr3017898lfb.578.1657743753343;
        Wed, 13 Jul 2022 13:22:33 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n1-20020a05651203e100b0047255d21124sm2997873lfq.83.2022.07.13.13.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 13:22:32 -0700 (PDT)
Date:   Wed, 13 Jul 2022 22:22:30 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Subject: Re: [GIT PULL 1/7] soc/tegra: Changes for v5.20-rc1
Message-ID: <Ys8phjCTfQTD41g+@orome>
References: <20220708185608.676474-1-thierry.reding@gmail.com>
 <20220708185608.676474-2-thierry.reding@gmail.com>
 <CAK8P3a1bKUr77t9xkNAX=-RqzRme6Hymr3V=36MSHT_sOFEW5A@mail.gmail.com>
 <Ys6lXD6BSxjH02mW@orome>
 <CAK8P3a0cSq47B=acZ854TVu=RckJNfyfKdqQUMzCX7SsV7Wt0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1NMJCDjm0OOidAIm"
Content-Disposition: inline
In-Reply-To: <CAK8P3a0cSq47B=acZ854TVu=RckJNfyfKdqQUMzCX7SsV7Wt0g@mail.gmail.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


--1NMJCDjm0OOidAIm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 13, 2022 at 02:14:27PM +0200, Arnd Bergmann wrote:
> On Wed, Jul 13, 2022 at 12:58 PM Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Tue, Jul 12, 2022 at 03:27:16PM +0200, Arnd Bergmann wrote:
> > > On Fri, Jul 8, 2022 at 8:56 PM Thierry Reding <thierry.reding@gmail.c=
om> wrote:
> > >
> > > I fear I'm going to skip this for the current merge window. It looks =
like
> > > the CBB driver you add here would fit into the existing drivers/edac/
> > > subsystem, or at the minimum should have been reviewed by the
> > > corresponding maintainers (added to Cc)  to decide whether it goes
> > > there or not.
> > >
> > > I had not previously seen this driver, but I'll let them have a look =
first.
> >
> > EDAC looks like it's used primarily for memory controllers, which this
> > is not. But then I also see explicit references to non-memory-controller
> > references in the infrastructure, so perhaps this does fit in there. The
> > CBB driver is primarily a means to provide additional information about
> > runtime errors, so it's not directly a means of discovering the errors
> > (they would be detected anyway and cause a crash) and I don't think we
> > have a means of correcting any of these errors.
>=20
> I think this is just a reflection of what other hardware can do:
> most machines only detect memory errors, but the EDAC subsystem
> can work with any type in principle. There are also a lot of
> conditions elsewhere that can be detected but not corrected.
>=20
> > I'll ask Sumit to work with the EDAC maintainers on this.
>=20
> Thanks
>=20
> > > For the other patches, I found two more problems:
> > >
> > > > Bitan Biswas (1):
> > > >       soc/tegra: fuse: Expose Tegra production status
> > >
> > > Please don't just add random attributes in the soc device infrastruct=
ure.
> > > This one has a completely generic name but a SoC specific
> > > meaning, and it lacks a description in Documentation/ABI.
> > > Not sure what the right ABI is here, but this is something that needs
> > > to be discussed more broadly when you send a new version.
> >
> > I wasn't aware that the SoC device infrastructure was restricted to only
> > standardized attributes. Looks like there are a few other outliers that
> > add custom attributes: UX500, ARM Integrator and RealView, and OMAP2.
> >
> > Do we have some other place where this kind of thing can be exposed? Or
> > do we just need to come up with some better way of namespacing these?
> > Perhaps it would also be sufficient if all of these were better
> > documented so that people know what to look for on their platform of
> > interest.
>=20
> It's not a 100% strict rule, I've just tried to limit it as much as possi=
ble,
> and sometimes missed drivers doing it anyway. My main goal here is
> to make things consistent between SoC families, so if one piece of
> information is provided by a number of them, I'd rather have a standard
> attribute, or a common way of encoding this in the existing attributes
> than to have too many custom attributes with similar names.

The major/minor attributes that we have on Tegra SoCs should be easy to
standardize. It seems like those could be fairly common. The other one
that we have is the "platform" one, which I suppose is not as easy to
standardize. I don't recall the exact details, but I think we're mostly
interested in whether or not the platform is simulation or silicon. The
exact simulation value is not something that userspace scripts will look
at, as far as I recall.

Jon, correct me if I'm wrong.

Perhaps this can be deprecated in favour of a more standardized property
that can more easily be implemented on other SoCs.

The production mode is something that is read from a fuse and we expose
those via the nvmem subsystem already. Currently nvmem exposes only a
binary attribute in sysfs that userspace would need to parse and ideally
we'd have something a little easier to work with, but perhaps nvmem can
be enhanced to expose individual cells as separate attributes in some
standard format. We also have some other values in the fuses that we
want to make available to userspace (IDs and that sort of thing), so
it's good that you noticed this now before we would've added even more.

> > > > YueHaibing (1):
> > > >      soc/tegra: fuse: Add missing DMADEVICES dependency
> > >
> > > This one fixes the warning the wrong way: we don't 'select' random
> > > drivers from other subsystems, and selecting the entire
> > > subsystem makes it worse. Just drop the 'select' here and
> > > enable the drivers in the defconfig.
> >
> > This doesn't actually select the DMADEVICES property. It adds a
> > dependency on DMADEVICES and if that is met it will select
> > TEGRA20_APB_DMA.
>=20
> My mistake. However, I still think it's wrong to select
> TEGRA20_APB_DMA here, unless there is a build-time
> dependency that prevents it from being compiled otherwise.
>=20
> The dmaengine subsystem is meant to abstract the relation
> between the drivers using DMA and those providing the feature,
> the same way we abstract all the other subsystems. The
> fuse driver may only be used on machines that use
> TEGRA20_APB_DMA, but neither the driver code nor
> Kconfig should care about that.

This dependency has existed for quite a while and my recollection is
that we wanted to make this very explicit because the lack of the
TEGRA20_APB_DMA driver makes the FUSE driver completely useless on
Tegra20 and that in turn has a very negative impact on the rest of the
system, so we deemed a default configuration change insufficient.

Perhaps a better way to solve this would be to make TEGRA20_APB_DMA
default to "y" if ARCH_TEGRA_2x_SOC. And then perhaps make the FUSE
driver depend on DMADEVICES. That still wouldn't ensure that we get
SOC_TEGRA_FUSE enabled automatically all the time, but perhaps it'd
document the dependency a bit more explicitly.

Thierry

--1NMJCDjm0OOidAIm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLPKYEACgkQ3SOs138+
s6E7KhAArkhj8xStaQwZq4ctlvtEVw9ueg7RKopF4KngJS4hngeF2k4GfHJ+CL0T
I5ZHhyVxvKZ4O7En/67H0oA+H07WUqsWXWgGwqINVHO9MvSYaUXr3Cp+q1rGebxp
4Fb7vikummMoStomTkLx10R1l2cY9JRr6rR2TWf/j3P3OTHTiL2k728AL5x0MEF0
eIZco/GLsXKFHW23vwmlQcportphtTrOdNFu1r3V2OpcJz2f2HycFwyQs3y38tOo
eGypDdPBUpgjVDBqoyMVxVQUuwPj4/REFd4vqS2XXPRROLtOZTVHU+p++NbtwFNE
/r6xGUgiNp+6pVFhz+dSIpzsxwMyjCyfZyLJlSEuCvuOV1ORBHTdquD8USYYAtn3
de2fbOH3LDehCYE++MDwYuTjpwXFt98rxJ6kSTaj5gTyVXqX2ZDAHq8oZYUCA0ZT
mkpjpvMjvwTXRm7wcr+GvATmUYkOOfyJJKnSn5DDU6WcOtqSt9Cw0K1iseU2k5nL
Hy41bkWlkvVi75xR/DgsNW+wDGfSt1PNNFGrIY97H81ZVuGdhG5uRcMEExGvVphq
c5vJnPWkKyMrVgcNuKKdeJt1CMXrFnf6x8BnXbU2ZRuhuwscYFat3J/UiKHwfixf
XXeYry7xFG+HokOmOS7T649dsKo50JrqpviW1C8eNOxHj9lpPCU=
=v92m
-----END PGP SIGNATURE-----

--1NMJCDjm0OOidAIm--
