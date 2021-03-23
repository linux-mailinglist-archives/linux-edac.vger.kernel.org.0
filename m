Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714ED34564F
	for <lists+linux-edac@lfdr.de>; Tue, 23 Mar 2021 04:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCWDgy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Mar 2021 23:36:54 -0400
Received: from mail-bn7nam10on2094.outbound.protection.outlook.com ([40.107.92.94]:13589
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229665AbhCWDgs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 22 Mar 2021 23:36:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2WhL2q5El1NeoylVn5osOmULNHAnq1RiXsy9vIFvt2ghkU/UuXRc8PFA/m3mH9HCh24JLOyRHgAG+vj7RMgB8oHMsj7WDCoDlkOHyRZpqVbwSpMRUszq7RFzOQQH0cqGx8I1DruSDj8OKK43TlozLI9tJRbl/mgFKA50JCaAMGj4vBosKmtHLumrP4Rv/DN7ITo5SaaN4hpiG7okt9VAaPWQeqGVxYB2VgD85PBQcVKYNmO56Dprpuvm0l3QihDIa18ETzlPMfLP+/MFCLWEjEAScb9/yf6BuUdAdwKbDhwg8Ln5Vhhebt2eSPnOeQe6eQOr6n0MY51ZnBj6npDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqaGvn8Ppb6+kAa2CVXJ0k/RDVRiRWOn3K9bfs6ZemA=;
 b=HQ4gzIXbjV+2gznHxmNKnXnv5MQPLGMpBMmqBqaUr3SmAuSXd+6d23/nP2QwBZdYmA3RBbP4qmP3kX8yoa+6a3hkgUKiVIcUcrvjYR5LUiMH6L/c4yZxfdfjbNIPK6ZpCrP2tSCyY6EkAficW5oFiT6KhSe7NqO1pkCR5ZlutuN7v4+IJrPaOydzGU6douvBEnBkRKoDphblbbmfbZE20V69l3LDGmHFRsCnT6jtnYonKmkIdTEGlMmkdpjHRnKJpA5biPox74hzKUX8yaXPvns3fezBf5bkAA6VIoOCDUYs/fSqjTAiVc1dSDq9sbma43NfRECfp9JEROTDtl/59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqaGvn8Ppb6+kAa2CVXJ0k/RDVRiRWOn3K9bfs6ZemA=;
 b=CfYOmzQrp5twrAqBiBUSqFPpMojTWj8gCFwNiP+NMiqSrLIg4NXBaEDNlFZD+hZ/20aPXc4SJR2DA9oRrkJGxTEU00fEVCoW6Nhl28wRTXaD7UBahUg040KJd8/FS1vqh+zwlE+hsyrtpoGEjV5mbtQz0xSD1jc3LF++E9LDM+s=
Received: from BY5PR22MB1841.namprd22.prod.outlook.com (2603:10b6:a03:21f::8)
 by SJ0PR22MB2624.namprd22.prod.outlook.com (2603:10b6:a03:319::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 03:36:44 +0000
Received: from BY5PR22MB1841.namprd22.prod.outlook.com
 ([fe80::f530:c94d:7eb2:4f97]) by BY5PR22MB1841.namprd22.prod.outlook.com
 ([fe80::f530:c94d:7eb2:4f97%3]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 03:36:44 +0000
From:   Kurt Martin <kmartin@wavecomp.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH 0/5] Remove dead linux-mips.org references
Thread-Topic: [EXTERNAL]Re: [PATCH 0/5] Remove dead linux-mips.org references
Thread-Index: AQHXCULWdQk/F3s/b0W7KeJnqupL6qpkeiOwgCtUCYCAAIabB4AAwwLo
Date:   Tue, 23 Mar 2021 03:36:44 +0000
Message-ID: <BY5PR22MB1841099C1E5A101308C52822C7649@BY5PR22MB1841.namprd22.prod.outlook.com>
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
 <alpine.DEB.2.21.2102221836030.1900@angie.orcam.me.uk>
 <BY5PR22MB1841658D64FB8D8B619BC870C7819@BY5PR22MB1841.namprd22.prod.outlook.com>,<CAKXUXMxOXCZyG3cw0NrNYfWjoTPuBahbT-sZo1N90PDvSJakZQ@mail.gmail.com>,<BY5PR22MB18410B38B795973450A10D4DC7659@BY5PR22MB1841.namprd22.prod.outlook.com>
In-Reply-To: <BY5PR22MB18410B38B795973450A10D4DC7659@BY5PR22MB1841.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wavecomp.com;
x-originating-ip: [99.8.154.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca5d3a7f-c4d3-40b3-4174-08d8edace166
x-ms-traffictypediagnostic: SJ0PR22MB2624:
x-microsoft-antispam-prvs: <SJ0PR22MB2624526906D32A40FF3DCCC7C7649@SJ0PR22MB2624.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CXyctt9UCsYuHMMYtdxrNxIsjf7E5Lg0DHNh2sPievbGyNKD3DlN90mnf3+7LX4P/j/BRTzmGFXRZn9G+gFP+ikZnhcSf8++Z2xSFJDs30XOwOWw+d41hZ5oKldrMDvHjGeLUkGkZlEYwU1T9DdtqSCqBkhjv4tNPD85ODsx34z/5r96hDT6ex+J4JCrSYwLs3Ip+ajG+Ew7zC56gY8QWDmWdNxxvKleEpatMxltKKQajoEYoPIPZz36laV31GDhUL8YhCC5T8BtmGq7vyI7GdzXewLcfiHAO8G4R/Ulq7jtiUSxmf5rLwS+fUJbGzZfKh7NSQiR82fY+xTEoQ5vtIFXtKA9KSWKSWKIdtViVI1NK239V0Gjecv05HdTbB7PG+uPidRvgapNWiotB7+ZM4+7aLeIAty6XHdm/HNo+/OBl2xW/VgEjqv9T8Ne4/PJEYK/96VBYclcsM6ZtTDvMB/9Rxh2iPUPx+xCfLaBGYYoDHjpqHit44CRjBJb9p3wvnXfiJmG/qMYyN9OpNJAKVSJjrObH6tlYrjjdTfHOpthF2SSJLOXtxDopbN22R0KR1NkyRe4l72QGxskHJI1pzQgyc4AlHQ7Djxgg6Mf33MmDSFofAD1WDEwQOJ8MyNVk2FC92fhZVouzSclFQYkhQLeM04YO40JNHgOZwxrgRk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR22MB1841.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39840400004)(136003)(366004)(52536014)(76116006)(26005)(8676002)(2906002)(66946007)(6916009)(71200400001)(66556008)(66446008)(64756008)(7416002)(66476007)(9686003)(4326008)(55016002)(8936002)(83380400001)(33656002)(478600001)(5660300002)(86362001)(6506007)(186003)(7696005)(53546011)(54906003)(38100700001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?KCiAhC8LBad/punkygmyBO2yTYqb5c7WnyldCcsJJNUxvyrEWs2hHbg4Tg?=
 =?iso-8859-1?Q?yC4LGFFcUIiUD7aE/Mtn6EpQK0oeHOErF1PRtg/vqEAZsLA+Zj2VKMFqj2?=
 =?iso-8859-1?Q?NHU6DmgwvCJKW1NQZEywGVOvVb5Fk6Red7j5tcWlP2uWoBZ3P4+0rjVC/c?=
 =?iso-8859-1?Q?4auIzh0LwyhWMK3j217ewaCS8ufmfmKjy1mYygoH+UyT19umTff3/ksFmU?=
 =?iso-8859-1?Q?BX19LuSJPI3Flh+PdxYWCH/tBUQMtOjbe6a1/tqyuzNGBfhCI6Qc4uipfP?=
 =?iso-8859-1?Q?HeHJiqYp6yCKZ0ffVjbCy9j/u7uDlgU62Nrmfqa85pPDmmofvprJPU6mI4?=
 =?iso-8859-1?Q?+wAJmffckvLyL0E+RQpWQczPm/0H3yEjRx13BPrKO85XRlZnnzhtijs8Pq?=
 =?iso-8859-1?Q?HomxIF/xxJXQmn48MvNaEVeC69b/nTCGrkffKDISujHR82a+h7p+xmwiOX?=
 =?iso-8859-1?Q?VWHFHN7oKYSAjE0wRdya72TQUxpRiAES+ug/HE4HebSO+nBTgbMzUh+IQp?=
 =?iso-8859-1?Q?MXSsXiZfMSnc03RD/P6wvTbkSAHTdE2FGmkDk5fMTijlajZhFJ0gB70ysU?=
 =?iso-8859-1?Q?dRpPn7H9ke/jzALO4/SDwVX0euvJsNkJVtRApM38+gHMtz1ziFQPHKbpcM?=
 =?iso-8859-1?Q?gIwLi1MH1g0TRi4+lEDllu5VxvEiQ9ujIpktZwIlth4Uwy6zQonibMArfe?=
 =?iso-8859-1?Q?63AxlbvBAL/2N1vPuajqKlIfTi5Rqvg6tGpYLggMm0rN7sRM/M91uv7l+j?=
 =?iso-8859-1?Q?q9CVQaJx5t2dU/6OXUigK6LycNHL4qR3OQPGjO3bqAxACVpXKANUAppgnf?=
 =?iso-8859-1?Q?pefai2q/X0pQ2JgIMsanV3HWSL58cjc676yXzecvlAH70kgaP6WzZoyOwG?=
 =?iso-8859-1?Q?8OI5VupNZKwOI4DoLyhCVfAzbaCsFszmA9anocpoGmDiub+sxqC1ALz+K2?=
 =?iso-8859-1?Q?6xx4dA4xFTGNXz3+IKjOCJMEKDdJB+bH+39GUqGR3G4MIjgfleGZnEDxOp?=
 =?iso-8859-1?Q?hrPlR0d+5mF4kOXmdHr3xEbZsToouA+0d1V+WmuoRzUgbpxXuzVgZih8jl?=
 =?iso-8859-1?Q?Hbvj9vPFvyEIWrq9q4NNF/X91VCCuBDQ9FNcBItcZ0QnDt1RUEr95slWKt?=
 =?iso-8859-1?Q?ZUsqjVNyXOFNMcooeQTfMVVNeyBoUipaioUMwxtY9ndhAIPleLKyt77RLo?=
 =?iso-8859-1?Q?GNjUbt2nnPSWNJu9zgl3I8B1wSFKI0+ePZzihmoOHaTc2ioR0g2tK/9w2c?=
 =?iso-8859-1?Q?lBNcJ4s6uwLiZ0ebCd37qfxHaMdSiY7IuTWVdk0pDnadjqr6GxA9QsNCdo?=
 =?iso-8859-1?Q?79ooGmeIAwqMAT822/IWOYsnI9JtaXn2+sIdv1GSquNJXnY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR22MB1841.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5d3a7f-c4d3-40b3-4174-08d8edace166
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 03:36:44.2557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzLfW0RZ8Hzc54qLrGma1D1W+DqGV0YJl6fzULFB0OXkKQR6yseQPAeEHTLPcgi0a2i/9L5V1geAMRN8WAOnZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR22MB2624
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This message was rejected by the spam filter at vger.kernel.org.  To ensure=
 that everybody on the original email list gets the reply, I'm resending it=
 as plain text (which I should have figured out long ago).  I profusely apo=
logize for the multiple resends.=0A=
=0A=
Hi Lukas,=0A=
=0A=
I apologize=A0for the delay.=A0 As you may know, we recently emerged from C=
hapter 11 reorganization and I'm working on a lot of issues related to this=
.=A0 I did get in touch=A0with Ralf, but I have not been able=A0to make pro=
gress with Hetzner.=A0 I'm dependent on Ralf to help me get the machine at =
Hetzner working again.=A0 I will continue=A0to try to do this.=0A=
=0A=
If waiting for me to get linux-mips.org working is not an option, I underst=
and that you may have to move on.=A0 I know the disappearance of linux-mips=
.org has caused problems for you.=A0 But can you please help me understand=
=A0the implication of your question: "should Thomas pick up the=A0remaining=
 patches of this series?"=A0 I am thinking the answer to that question is y=
es, but I'm not sure if I'm the right person to answer that question.=A0=A0=
I guess I am somewhat clueless about how the patch process works for MIPS, =
and how linux-mips.org is involved.=A0 If I am never able=A0to get linux-mi=
ps.org back online, what does that=A0mean?=0A=
=0A=
So please understand that I want to keep the "MIPS infrastructure" items su=
ch as linux-mips.org functioning.=A0 Any help or suggestions are welcomed.=
=A0 Thank=A0you.=0A=
=0A=
Regards,=0A=
=0A=
Kurt=0A=
=0A=
=0A=
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>=0A=
Sent: Monday, March 22, 2021 12:52 AM=0A=
To: Kurt Martin <kmartin@wavecomp.com>=0A=
Cc: Maciej W. Rozycki <macro@orcam.me.uk>; Thomas Bogendoerfer <tsbogend@al=
pha.franken.de>; linux-mips@vger.kernel.org <linux-mips@vger.kernel.org>; T=
iezhu Yang <yangtiezhu@loongson.cn>; Willy Tarreau <w@1wt.eu>; linux-edac@v=
ger.kernel.org <linux-edac@vger.kernel.org>; linux-hams@vger.kernel.org <li=
nux-hams@vger.kernel.org>; kernel-janitors@vger.kernel.org <kernel-janitors=
@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.o=
rg>=0A=
Subject: Re: [EXTERNAL]Re: [PATCH 0/5] Remove dead linux-mips.org reference=
s =0A=
=A0=0A=
On Mon, Feb 22, 2021 at 7:19 PM Kurt Martin <kmartin@wavecomp.com> wrote:=
=0A=
>=0A=
> Hi Everybody,=0A=
>=0A=
> This is Kurt Martin.=A0 I'm part of the MIPS Customer Engineering team at=
 Wave Computing.=A0 Some of you may remember me.=A0 I have just established=
 contact with Ralf, and I will be working with him to restore linux-mips.or=
g back to life.=A0 I just got the account and login information for the lin=
ux-mips.org hosting account at Hetzner from Chris Dearman.=0A=
>=0A=
> So as Maciej says, please hold off any actions at this time, and I will a=
ttempt to get linux-mips.org working again as quickly as possible.=A0 Thank=
s!=0A=
>=0A=
=0A=
It has been a month by now... I just wanted to check if linux-mips.org=0A=
is back on its way to be available. Or should Thomas pick up the=0A=
remaining patches of this series?=0A=
=0A=
Lukas=
