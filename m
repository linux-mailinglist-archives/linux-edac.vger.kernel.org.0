Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C839A7301
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2019 21:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfICTAu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Sep 2019 15:00:50 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:34266 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbfICTAu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Sep 2019 15:00:50 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x83Isqkx029635;
        Tue, 3 Sep 2019 12:00:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=8JXCS9B755gIuiGAWuBRGjuPSwooVZmSVQMeP7mxyD0=;
 b=FxZ5kwZ8J44y4QDcHfCIHRBrIdl1QXOpCm97hBLFJMFmjX6u+MywAce9C3CqT9zRAZZf
 wiVoHAR8hsqtEOM09jkA5fO7633Qg+jN1xKwV041YS0M5tq81kdCubx4yfpHVEKloKTJ
 iCvbvoqP3CdHWelISKdlvMpZMXVlkIGlEnHx/oIYjLfRX8qnSSqVrDIoexztvxeL/8M9
 WzpeNICBy/w8GGt9pw6mWGXasmLhi4v/nDB6bwdZAIw4h0fpphLGHB/M99Z8c5ihlv8R
 SRuV7TOuZGUcXaxjA0ky5PX2vk5RHpn8FB4DW05QYmw7vkG7tBZdg9dZuQniA7+zrIH1 TQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdmasq8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 12:00:29 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 3 Sep
 2019 12:00:27 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.53) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 3 Sep 2019 12:00:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRMydGyRqHp5SPPk7EzqYYIz2co+qrqEJ2Ldsbu5VG/DmNvBscPVakvTqTr4OxwXXoWyz0YW+Ca+rGLG+xLKbTLiL/h2W+M/fmXv+bhM22IVaEB4C+LOrxYRuk6yIhjE8pqpPjNKp475yg86YIGDqznZbFSzFmWu485SJ/uZSphM5EM4jLGVWBBfkLlihMI/EzKh0SP7i27nPG6ykolcZ0Zz1I8HLM9JMO7MLF8rvM7Txn3wSd6La20H3bu+YrV4O2Vc+oSjPhMwzSfgQ92g4hnyw2dKiGsQJv5M3ajjWj/jRc2RGHA/TM5qQAExEEBtJUHnAs0ZcIfHIpdvaRYT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JXCS9B755gIuiGAWuBRGjuPSwooVZmSVQMeP7mxyD0=;
 b=REdbJV3i1dyat+Bo7kln5IWCE840Mj8mSTrgaPB24jgbDYqnLXsRuMuMkWHP4yx84Mk+IPCwzZUWYhi1PWJvrqJThtnJFi15UyFlQFElRwXVFW0JX+nS7qfh9gT7AJ/XOjt2xmyTxdR3gEWNsX0L2KCVJ1OcUMKDumv8DxpytqzatKZdp8QAbG3SHqkWIu/v4rfo5eTydQbYlrVxaDLbaCfcK73fbfXuSn7mrafcEdmo6A92uTL8UawR7FInreo3bNkYgoDqf+owa1g/dcnTxRHZQblyiJ1Nbyj9dBVJTD9p+MN0Mikzf9nMNansxlfuypqzMhLanmMAoyd3U/CAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JXCS9B755gIuiGAWuBRGjuPSwooVZmSVQMeP7mxyD0=;
 b=Iq4bJE9OsbXQPhFBDnGfE1+12lXjOV04rCJshRxF1xaHF2fg6KckSRlAKGrV4ZUSWdDK7/iw8Qi4LVXW8SJUYceywh60hAksUtT372O6qkJEpqsydjzFwXUbn7J4+VYofehEU5f3Wka/9L044F6jwgPV0Xqcpw5w9QQWOwam5O0=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2493.namprd18.prod.outlook.com (20.179.81.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Tue, 3 Sep 2019 19:00:24 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2220.013; Tue, 3 Sep 2019
 19:00:23 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Hawa, Hanna" <hhhawa@amazon.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] edac: Add support for Amazon's Annapurna Labs L2
 EDAC
Thread-Topic: [PATCH v3 4/4] edac: Add support for Amazon's Annapurna Labs L2
 EDAC
Thread-Index: AQHVYonWEW366PYabUiBfS2NTGGd3g==
Date:   Tue, 3 Sep 2019 19:00:23 +0000
Message-ID: <20190903190012.td3avaqkvwcp22lt@rric.localdomain>
References: <1563197049-12679-1-git-send-email-hhhawa@amazon.com>
 <1563197049-12679-5-git-send-email-hhhawa@amazon.com>
 <20190903072655.kz5x7n3477dg4yap@rric.localdomain>
 <2bce020a-bf7e-1d54-48c3-0aa6d23c84d8@amazon.com>
 <20190903084614.mthff6hzbchkw7t2@rric.localdomain>
 <20190903085816.GA11641@zn.tnic>
In-Reply-To: <20190903085816.GA11641@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0032.eurprd09.prod.outlook.com
 (2603:10a6:7:15::21) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5984831a-2af4-4677-eeca-08d730a0f92b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2493;
x-ms-traffictypediagnostic: MN2PR18MB2493:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR18MB2493CF7C6454E1A83939EE3CD9B90@MN2PR18MB2493.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(47630400002)(189003)(51914003)(199004)(4326008)(6436002)(66946007)(476003)(53546011)(386003)(6506007)(186003)(26005)(6306002)(102836004)(6486002)(966005)(486006)(53936002)(446003)(71200400001)(71190400001)(99286004)(52116002)(316002)(256004)(25786009)(66446008)(66476007)(66556008)(64756008)(478600001)(14454004)(9686003)(6512007)(2906002)(7416002)(8936002)(11346002)(76176011)(54906003)(86362001)(4744005)(305945005)(3846002)(6916009)(7736002)(6116002)(81166006)(81156014)(229853002)(5660300002)(66066001)(6246003)(1076003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2493;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EIfHd/0uI2Lm5j1/aEyCORmrst8kBgbtQr3zrt3FChaxE+I7W1AG4dlC4fXBNwyE2uVKnm5ho9BbXxg60qofwrslUND/F9a+LxS9d+2KHFlvGz795q2JjHfIS/olnTsBiTT/InXfYP4QEPBkYuc+en5+//30L2aHMADq7yRBjgFC70BKk2zItNKuljeg71coa1zP7be5VrCewrlvMm5iSowC54d7xqN0i1fR6QxXRjYrn8j3fQthF6Kew7ufE3n+2M28SaurBoDHXYhem7iSeje7P4i/V/90WcZf3AhTLr2OoJi+x7DOGIlg7HwhxfpTSmB1bGq2hPtElrZYW/GJ2WrDci/HlmIjcbRTukfUExvAQtwaaJ7kJHlMor+O3FucjEs3fK5KPoVLeduolCxZE548BNLGUzApUNgTr4l4/W4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F83D9A890EB81D4DA7E0E602B7F88189@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5984831a-2af4-4677-eeca-08d730a0f92b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 19:00:23.6796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywgHrUGlJZ989IkKbxeKYTwv8f2HTji52VgC3kBVhaRGVGcw+tNa0POf+RgKxfXx9aYD5pRTRFIoecMFYgXSJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2493
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-03_04:2019-09-03,2019-09-03 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 03.09.19 10:58:16, Borislav Petkov wrote:
> On Tue, Sep 03, 2019 at 08:46:24AM +0000, Robert Richter wrote:
> > This is good, but recent practice is also to have all the drivers for
> > the same piece of hardware in a single file, see e.g. thunderx_edac.c.
> > I don't know how detailed this was discussed already, but I would
> > prefer to join the code.
>=20
> This is no longer needed anymore. Check out this thread:
>=20
> https://lkml.kernel.org/r/1559211329-13098-3-git-send-email-hhhawa@amazon=
.com

Thanks for the pointer, looks good to me.

-Robert
