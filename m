Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEAB400130
	for <lists+linux-edac@lfdr.de>; Fri,  3 Sep 2021 16:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349335AbhICO0m (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Sep 2021 10:26:42 -0400
Received: from mail-dm6nam12on2123.outbound.protection.outlook.com ([40.107.243.123]:41824
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233092AbhICO0m (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 3 Sep 2021 10:26:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9Wy2KADJa7EvNI+/pF912GTTSgDjLrBoV14jhiz4GkCmSW+7WenJXPzJWZIzr+PPLam1I7pIg6gEf6vlFsHLfK5yvydFwqVLVD/xcJvru8YVR1tVvi9PqxG7gvDBd/pJUw9l68WKuDCIXKGMiYbd8eT+FhOD3aZ6wf1FQhVwQobyMIGmlm9PzOz6w5aMlrxepQN4mZEkY96nnE1z8nnFU7pjcIvnuWXSGhavnpSr3YpCEOOz1Vd4EvuD80z1okZBP4Z/Y8z1Us184MAA4G4QtO/n5IzHhN1xg/U4s6Wnr2yJQgv0nhizLu7Rev9B5o/lufXfypvSthlLBhQXGX92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=eFspCowtcGuo+fBPrFa9AnY9nU/EQUyAKb0yCsZH2rc=;
 b=Rk9+9atRBwLSAIsixbsrm2S+jTUGw6hdbAtinxUZaiy0ObzsO3RXJVCAbxW5MrtZMeAkHwkNTTlr6q7nDV854OqUG+5b+Jm2muJC7Khl4aOgZU38jjYJ1gUsoZ7k+kwX+hX+mZeC1eBUIhO5/xvhlS4/ZkhkVPGNWxlM3004LeVoNJUwwnUZx7maga8nozBLz3Z/HqsS4xT5ILJlCZc3RSguIR8f7uy/b7rySjnF2naz6BOgvael2P5P9dz3wMJJTfWMm+dR+6xwg1nguoAghma70XI+OkmjbEKDfmYIV2i8rn2Uo5HDOoYhVmUe7nuYHLt5LhtsHLLc2C/DdjltkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=coreavi.com; dmarc=pass action=none header.from=coreavi.com;
 dkim=pass header.d=coreavi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ch1group.onmicrosoft.com; s=selector2-ch1group-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFspCowtcGuo+fBPrFa9AnY9nU/EQUyAKb0yCsZH2rc=;
 b=nScml0bL01WTZfE4f8moR2GimGe+X0a4j7EsNQ/qqqm/Dp3cP605wIEWojq2miboEEwBDaF1w6AkVDUi8OmhB3Oez79XBAwb89Jnu7BeIvr8OxQDAzdDcwHwqwCXx+LdsWvna/Yf0rMlUqKFTua3MxDwxsl8IU0dhSyoP7AAIL8=
Received: from DM8PR22MB2760.namprd22.prod.outlook.com (2603:10b6:8:23::17) by
 DM8PR22MB2758.namprd22.prod.outlook.com (2603:10b6:8:21::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.17; Fri, 3 Sep 2021 14:25:41 +0000
Received: from DM8PR22MB2760.namprd22.prod.outlook.com
 ([fe80::54ca:45a4:4847:33a1]) by DM8PR22MB2760.namprd22.prod.outlook.com
 ([fe80::54ca:45a4:4847:33a1%3]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 14:25:41 +0000
From:   Lucas Fryzek <lucas.fryzek@coreavi.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     Tasos Sachanidis <Tasos.Sachanidis@coreavi.com>
Subject: Error injection interface for igen6 driver with Intel TGL UP3
 hardware
Thread-Topic: Error injection interface for igen6 driver with Intel TGL UP3
 hardware
Thread-Index: AdegIY55w7FLAYKlRm+7S8+0PntwRA==
Date:   Fri, 3 Sep 2021 14:25:41 +0000
Message-ID: <DM8PR22MB2760C71E24679B1BF6732F4A8FCF9@DM8PR22MB2760.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=coreavi.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e544673-0830-42ea-7b6d-08d96ee6b55e
x-ms-traffictypediagnostic: DM8PR22MB2758:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR22MB2758F583D3041D0C0BCC75B98FCF9@DM8PR22MB2758.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QuE5MWkxnvNTuJBvgLvD4E2RPeyrX79Yl5oHJ0O8iT/nQ3Now30hD2Mc11uuw/ufRMlfyzttvdnAhXwvso+8076y1UmivCQw+8n2KFvNRbofC+lJ0Uhhj/rE8p7ixzoqSFbvRqOOb6Mt/I56gsbaKdP/FA+TCf21bz2UEfnBbw3DW4Yh/yv3LP9MrHd9fLo7uPpzD9VTt5VNaxQQVyI3KBveIP3jE1icMmIt6G6MPm14rIaCLY8BEweJOIwCdpatuFw++FwwpE1Kh4nIs17JzMzhvH6urPAETOTwX5CeQqUlVqj8DmveAE+MHW3XtuVs3BvvC0GqNvcQ1w9YVA01nzV8/3AgiCcah8AwsqAE6bW9KqfRQnZXhxZnnyUg1h841xU7QnTdBXARoXysGMr8EIAyFXkqI4ksW2OL1qeW1c6Y/d0HMxG7l9WGdDiKJ7dmfnLpzcD5ZRVAsiXM5YOmlnynqojotvUL8+Ffc+GcazJ6GTpnMQXoHwSB/Ax2ob0JKSmPAw8LIyQZnjUKwgysKFl8Wf8SAET4QpVMNlfkzF5H/TigFHi4z616AIbC2lN/y5aNH7/RlGb89OI0ld5/stOCIpzZjQ5yEPd9u9DTlRLQDcNjQNbTFeIuc+aCdbdpyY7XeOIqo0T9V4fMpv9LpcJslJTNV5+s6qWJFGmffxV+SZb4OZgwCtZOA8dmYJ1uAASoSn4Q4V58726g8V6viQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR22MB2760.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(366004)(396003)(346002)(376002)(136003)(7696005)(44832011)(8676002)(33656002)(6506007)(52536014)(86362001)(38100700002)(2906002)(38070700005)(4326008)(508600001)(122000001)(4744005)(6916009)(66946007)(66476007)(66446008)(107886003)(64756008)(186003)(76116006)(8936002)(55016002)(316002)(66556008)(9686003)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sXWmWD7I7AWBsjRqFQEeoNoUSXnDz1uxz9SugCFL2HOEZYhShkVI52NqAe3/?=
 =?us-ascii?Q?ehNWx6m0CLYBdW7SN1VwTlZSe/h4hncv6uddmevGlVr7Dc1GAn7S701XzUzk?=
 =?us-ascii?Q?4IilFEtOCxAuIwaW287cPRAyPKzLwvKcbWHhtNA2wq5imYjR6zcV4Rq0WuMH?=
 =?us-ascii?Q?FKKbAqlCUAXd0qsrJPA5MrzRQ+KO8fKgxDEulLnEWySWbsT1ZfHQe7lZRxMK?=
 =?us-ascii?Q?TsiKRGhu2ZFOYLMYK9Q//cWoAuFmcblolpZVBxs1OOmmVRBWWNt9SnhMs9Sy?=
 =?us-ascii?Q?UgaPk1anDZI5YM3Y7Oi7FYUHZTdczf7vYct6cjf7/GFRO07I8Ey24ZPQvpyR?=
 =?us-ascii?Q?V2FKuhO3UfhIssoCGrd3OHPtTkw/GU9xEXYhGkrols9ICrdtSf0ULSakKgte?=
 =?us-ascii?Q?6qzvvbBMuHb8jcsSTjJBTLyRPppvxPxqAGQwheyHsC0pKZBK8A5paWlPN8QX?=
 =?us-ascii?Q?bewoNl49DoYGuwnlX9HgSS8UgT6KIc5gYg7pKeZdeiqqIZH7Doe0Hn6ks0QG?=
 =?us-ascii?Q?YcJ38a/IBOblcJBW0A852SzWX6ofqErTuIc0KpB4+6HE8a2i8DUmHnCe5aVc?=
 =?us-ascii?Q?fMlKohACKSCtLxyzWMKn9L3zxNY6frG2rU7BottRtCXfwSkhyRsm17ET2Sdp?=
 =?us-ascii?Q?fZcXNtRBOh2S96JTdmbiuvcQ+T4xcXWdWJ2rAelEmxSgEnfO1Q4D1rLwWSoA?=
 =?us-ascii?Q?6mQl1DWqtqdaBbiiP/BByj4LDx1kXZ9ovUfCCOfHdZFuV7cBoppirAJc72+c?=
 =?us-ascii?Q?zlc57g7OUBr4BrGiUOFpGLK254Uk29t9GMraK7JSR76O/eobvOaPhCXaFHHt?=
 =?us-ascii?Q?m9RQIYB8ApKT/g8yjzZU5pmkyrZr9fHUEfxCeSuhKpf5bmZ/zvep5rrG/n1B?=
 =?us-ascii?Q?zLiJx1T9m4NJXcj1rsUo7jpitf1Wl0cBnwYcSfbzra3CiMCfTgmqiVqZVDHV?=
 =?us-ascii?Q?81o4mscDIex2r8rShkSnFmzs+aqyboVQs0bNlih7Amrzva66Lg0bySV749hd?=
 =?us-ascii?Q?WKNBSu4nwx8QMAW816wGvXhKn0dNc7ZohjCKGqybpCZo9tmKzfpSkvDZQ6so?=
 =?us-ascii?Q?G8sqcxLmlxOXo9JgScVy0CrdHRLr061ZE7iZhfu43anFRrR1hDdXKJJXs5Ns?=
 =?us-ascii?Q?m8fXEapSsYPF4p1vHPh0wrehR3vi8GXCnjkaXXQy0SO8X1wRENj9qL//PIyc?=
 =?us-ascii?Q?AD8MEUY5OFFuVOdOJzAe91Czr4ryBb8tB5+gI5JJw5b53eIRkmmcidb8rNtk?=
 =?us-ascii?Q?lSucQrZN/piRezn6hNMZs1HiKedDJJCMk527HgrVcwXDvmkeJaKw1UIu6hpO?=
 =?us-ascii?Q?VsFlYEUdD2ZqBYEn4+d5vHnSTnATejdnGyjpkaK3kLae57hZydaui/AEX0rK?=
 =?us-ascii?Q?qLP5JSLIDmuwqMDS95+PV3t2dmUr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: coreavi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR22MB2760.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e544673-0830-42ea-7b6d-08d96ee6b55e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2021 14:25:41.1428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 76f7f3b2-94a1-4806-8168-1230a353cde3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTNQ5faqUdo03s5+n8TO17nZo5Kdni31EXr7E2rI2k6tx/2q/n+HBz0AuIWe7PsI2lFZmUZRsgDIfZp6aBn5S3kQKp8Y2mSio8ncO3wje9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR22MB2758
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello,

We are working with some new Intel Tiger Lake hardware (specifically a boar=
d with the 1185-GRE SKU) and are running kernel version 5.14.0 rc3, compile=
d with debug support for EDAC. The igen6 driver appears to be loaded and ru=
nning, but it does appear to export any interfaces to test error injection =
on the hardware. We have made sure that IBECC is enabled in the bios and th=
e they IBECC error injection feature is also enabled in the bios.

Does the current igen6 driver support error injection on Tiger Lake? How ca=
n we test IBECC support on Tiger Lake?

Thanks,
Lucas=20
