Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1226350FE8
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfFXPKg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:10:36 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:54722 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730364AbfFXPJ3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:29 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF8CWO025874;
        Mon, 24 Jun 2019 08:09:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=FklElvgedlxDHmIG/ABCr6f2J/sCXfLx67VSbR25Q5o=;
 b=EHawC+34zHZyx9xY2E33vW2QkorXflFdB/Xk+MElQgmu4KvyLxah/zO9pxlNmpQGSjbT
 k3+4cyqmup+3Ot6DqM6rDEhXZaENEAOi1szUcKu56PW+buAchcvvzHl0Vt0u8dSis1/I
 xmmANyNComb5pYC6WtctK5FQ6VsNCFRSOjIH2xB6P2JvLaeT07pBMlMD77qhZY+Kts+E
 jzsXReRtLHOvYAJQYugaYgARYg63D93+QI2DPfSxR+7XkN/mE5b0T5LH2oUfTYdMJP1n
 6BcV/hSwMop6CwIIB5wCpUPSmrmjID3HZXvrm82OBFf8bYkBR5BSD/MoOqkftnFLc3LI AA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kujf7t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:09:24 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:09:22 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.58) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:09:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FklElvgedlxDHmIG/ABCr6f2J/sCXfLx67VSbR25Q5o=;
 b=f0aML//0mcuYNI7tE1UyNsEyDi/jMOU7HayahASor8+9fzTaTk5tkilJtN0c99s9P1QGWQ95V88evLSH92rOCIYIn6IvBVrTuX+PAUyZqwFkU3vz3xUytF713UMCx8C40vesguuDN8lsdImYGKrtyrj+zT3yhDZfJfBa0TtXQs8=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3197.namprd18.prod.outlook.com (10.255.236.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 15:09:20 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:09:20 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 12/24] EDAC, ghes: Use standard kernel macros for page
 calculations
Thread-Topic: [PATCH v2 12/24] EDAC, ghes: Use standard kernel macros for page
 calculations
Thread-Index: AQHVKp7MsQEaEpqGeEG+xGBTWNT6kw==
Date:   Mon, 24 Jun 2019 15:09:19 +0000
Message-ID: <20190624150758.6695-13-rrichter@marvell.com>
References: <20190624150758.6695-1-rrichter@marvell.com>
In-Reply-To: <20190624150758.6695-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0035.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::24)
 To MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [92.254.182.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f0715b6-9e29-4e7b-2e44-08d6f8b5ee71
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3197;
x-ms-traffictypediagnostic: MN2PR18MB3197:
x-microsoft-antispam-prvs: <MN2PR18MB319793F8971DCD88EEAA0F70D9E00@MN2PR18MB3197.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(36756003)(110136005)(107886003)(54906003)(81156014)(81166006)(68736007)(8676002)(4744005)(25786009)(5660300002)(8936002)(305945005)(7736002)(4326008)(1076003)(186003)(6116002)(14454004)(476003)(486006)(2616005)(11346002)(256004)(446003)(3846002)(50226002)(26005)(2906002)(52116002)(76176011)(71200400001)(71190400001)(99286004)(386003)(6506007)(102836004)(478600001)(316002)(86362001)(6512007)(66066001)(53936002)(6486002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3197;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c2/rqZ0PLIGnyy06a1C904OAxaeVBVSN2vTZtlq0lMlQS/rebaivybftuwZhd1kgLN4dUMLTgBBqBbSOpZGEyecqkabDBkPBhE4qGzQw8gVPDyc1DpegTSr5QFcaK4qGX/YT8jrGIFaePn5royywHS/ChiWyarJ26tdcVPXSEZfYlv0FJnL0jO67/8i0+nCVVeDU837qbSUCKsQ8XALXatbgOT+6swixCI432H1d9BJI50PwkDw42aQFZG1JDZunfeBkjuRRJqfoeWDEKlUOVCk2X+fwSbUci/MXO4aGXS7g6HwHiFUJdmM2niaon6gQR/9V+qRPcPBRFG1oyBeVike4HoZqt6GzMJUF8cv+VMrO+6V5UINbBeU6ors8ugYFGRggCN3HyColzyEM+XzAa7qdCp1UCHSyTsaqyvYkTwo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0715b6-9e29-4e7b-2e44-08d6f8b5ee71
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:09:20.0173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3197
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_10:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

VXNlIHN0YW5kYXJkIG1hY3JvcyBmb3IgcGFnZSBjYWxjdWxhdGlvbnMuDQoNClNpZ25lZC1vZmYt
Ynk6IFJvYmVydCBSaWNodGVyIDxycmljaHRlckBtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
ZWRhYy9naGVzX2VkYWMuYyB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvZ2hlc19lZGFj
LmMgYi9kcml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCmluZGV4IDc4NmYxYjMyZWVlMS4uNzQ2MDgz
ODc2YjVmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQorKysgYi9kcml2
ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCkBAIC0zMTEsOCArMzExLDggQEAgdm9pZCBnaGVzX2VkYWNf
cmVwb3J0X21lbV9lcnJvcihpbnQgc2V2LCBzdHJ1Y3QgY3Blcl9zZWNfbWVtX2VyciAqbWVtX2Vy
cikNCiANCiAJLyogRXJyb3IgYWRkcmVzcyAqLw0KIAlpZiAobWVtX2Vyci0+dmFsaWRhdGlvbl9i
aXRzICYgQ1BFUl9NRU1fVkFMSURfUEEpIHsNCi0JCWUtPnBhZ2VfZnJhbWVfbnVtYmVyID0gbWVt
X2Vyci0+cGh5c2ljYWxfYWRkciA+PiBQQUdFX1NISUZUOw0KLQkJZS0+b2Zmc2V0X2luX3BhZ2Ug
PSBtZW1fZXJyLT5waHlzaWNhbF9hZGRyICYgflBBR0VfTUFTSzsNCisJCWUtPnBhZ2VfZnJhbWVf
bnVtYmVyID0gUEhZU19QRk4obWVtX2Vyci0+cGh5c2ljYWxfYWRkcik7DQorCQllLT5vZmZzZXRf
aW5fcGFnZSA9IG9mZnNldF9pbl9wYWdlKG1lbV9lcnItPnBoeXNpY2FsX2FkZHIpOw0KIAl9DQog
DQogCS8qIEVycm9yIGdyYWluICovDQotLSANCjIuMjAuMQ0KDQo=
