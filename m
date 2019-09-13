Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 555D3B24D7
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2019 20:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbfIMSFS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Sep 2019 14:05:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387471AbfIMSFS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 13 Sep 2019 14:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6FeydvuMSyFH5WFdFmV29KNR4XubywUJhosL4frnFWg=; b=ORJ/R7wjjla/6INq3ICv5Ux+n
        LOzC4bRtAQsQAf0M+n+kS+iOctQArTc9sBuiB3spkNC4fTnGg8TpGFeoDRRiW9IPEDHpfGbtrNXHf
        kjmgQqe9ujn85tmVTkl0CNkpCGmKBVvInLpnUVlsiaaTQhqYcBx3W2KWPAE6lfEfZpthVUKheBQ9H
        O+bsrbGrASxDCmo5LkuNyUiERPLnDrxs0i/fEXA6piLbbLrd4bf4RGGgz1Fh7/zcjBX2WQuQAmCTz
        4HQRG34Pjg8doJ/Itbuh9Yys93zYHlaa+fc4UDwZAZtbg9bO1F9TFpLCcX6Z6ZI6gaUaHEpn6wesw
        o1umAXYvA==;
Received: from 177.96.232.144.dynamic.adsl.gvt.net.br ([177.96.232.144] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8pwa-0000Qa-P3; Fri, 13 Sep 2019 18:05:17 +0000
Date:   Fri, 13 Sep 2019 15:05:12 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        James Morse <james.morse@arm.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>
Subject: Re: [PATCH 0/7] Address most issues when building with W=1
Message-ID: <20190913150512.6c4e4d87@coco.lan>
In-Reply-To: <20190913175320.GD4190@zn.tnic>
References: <cover.1568385816.git.mchehab+samsung@kernel.org>
        <20190913175320.GD4190@zn.tnic>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Fri, 13 Sep 2019 19:53:20 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Fri, Sep 13, 2019 at 11:50:25AM -0300, Mauro Carvalho Chehab wrote:
> > There is a recent discussion at KS ML with regards to use W=3D1 as defa=
ult.
> >=20
> > No idea if this will happen or not, but it doesn't hurt cleaning up W=
=3D1
> > warnings from the EDAC subsystem, specially since it helps to cleanup
> > a few things.
> >=20
> > This patch series addresses most of such warnings.  After this series,
> > there will be just two W=3D1 warnings:
> >=20
> > 1) i5100 EDAC driver:
> >=20
> > 	drivers/edac/i5100_edac.c: In function =E2=80=98i5100_read_log=E2=80=
=99:
> > 	drivers/edac/i5100_edac.c:487:11: warning: variable =E2=80=98ecc_loc=
=E2=80=99 set but not used [-Wunused-but-set-variable]
> > 	  487 |  unsigned ecc_loc =3D 0;
> > 	      |           ^~~~~~~
> >=20
> >=20
> >    The ecc_loc contents is filled from MC data, but it is not used anyw=
ere.
> >    The i5100 MC is very old: the affected code was added in 2008. It sh=
ould
> >    probably be safe to just drop the corresponding data, but, as it may
> >    contain some relevant info, I was a little reticent of doing that.
> >=20
> > 2) Xgene EDAC driver:
> >=20
> > 	drivers/edac/xgene_edac.c: In function =E2=80=98xgene_edac_rb_report=
=E2=80=99:
> > 	drivers/edac/xgene_edac.c:1486:7: warning: variable =E2=80=98address=
=E2=80=99 set but not used [-Wunused-but-set-variable]
> > 	 1486 |   u32 address;
> > 	      |       ^~~~~~~
> >=20
> >    I suspect that the content of the address field should actually be u=
sed on
> >    at least some of the logs. =20
>=20
> + Khuong Dinh <khuong@os.amperecomputing.com> for that.

Thanks!

>=20
> > I may eventually submit patches later to address the above cases, but l=
et's
> > solve first the other cases, as they all sound trivial enough.
> >=20
> > Mauro Carvalho Chehab (7):
> >   EDAC: i5100_edac: get rid of an unused var
> >   EDAC: i7300_edac: rename a kernel-doc var description
> >   EDAC: i7300_edac: fix a kernel-doc syntax
> >   EDAC: i5400_edac: print type at debug message
> >   EDAC: i5400_edac: get rid of some unused vars
> >   EDAC: sb_edac: get rid of unused vars
> >   EDAC: skx_common: get rid of unused type var
> >=20
> >  drivers/edac/i5100_edac.c |  2 --
> >  drivers/edac/i5400_edac.c | 15 +++------------
> >  drivers/edac/i7300_edac.c |  4 ++--
> >  drivers/edac/sb_edac.c    | 21 ++++++++-------------
> >  drivers/edac/skx_common.c |  5 +----
> >  5 files changed, 14 insertions(+), 33 deletions(-) =20
>=20
> Looks ok to me at a quick glance, ACK.
>=20
> I've already sent the 5.4 pull request to Linus so you could queue those
> after -rc1. It's not like they're urgent or so.

Yeah, that's my plan.

Thanks,
Mauro
